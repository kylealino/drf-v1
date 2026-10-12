<?php

namespace App\Controllers;

class MyRequest extends BaseController
{
    protected $myrequest;
    protected $mychat;
    protected $mydoc;
    protected $session;
    protected $cuser;

    public function __construct()
    {
        $this->request = \Config\Services::request();
        $this->myrequest = model('App\Models\MyRequestModel');
        $this->mychat = model('App\Models\MyRequestChatModel');
        $this->mydoc = model('App\Models\MyRequestDocModel');
        $this->session = session();
        $this->cuser = $this->session->get('__xsys_myuserzicas__');
    }

    // Requesters file, sign and follow their own requests here. The request
    // page, its PDF and signatures are shared with the "Noted by" signatory and
    // HR - the model only hands a request to those three. The conversation is
    // between the requester and HR; the signatory gets the request's log.
    public function index() {

        $meaction = $this->request->getPostGet('meaction');
        $isPost = strtolower($this->request->getMethod()) === 'post';

        // PHP drops the whole POST when it is over post_max_size (big uploads)
        if ($meaction === null && $isPost && (int) $this->request->getServer('CONTENT_LENGTH') > 0) {
            return $this->response->setStatusCode(413)->setJSON(['error' => 'Files are too big to send. Try fewer or smaller files.']);
        }

        // saving and sending only ever come from a form post
        if (in_array($meaction, ['MAIN-SAVE', 'CHAT-SEND'], true) && !$isPost) {
            return $this->response->setStatusCode(405)->setJSON(['error' => 'Not allowed.']);
        }

        switch ($meaction) {
            case 'FORM':
                return $this->loadFormView();

            case 'MAIN-SAVE':
                return $this->json($this->myrequest->request_save());

            case 'VIEW':
                return $this->loadRequestView();

            case 'SIGN-FILE':
                return $this->signature();

            case 'PRINT':
                return $this->printRequest();

            //SPECIAL ORDER - the document HR prepared (requester: once released)
            case 'DOC':
                return $this->document(false);

            case 'DOC-WORD':
                return $this->document(true);

            //CONVERSATION
            case 'CHAT-LOAD':
                $hd = $this->myrequest->request_get($this->request->getGet('recid'));
                if ($hd === null) {
                    return $this->response->setStatusCode(404)->setJSON(['error' => 'Request not found.']);
                }
                return $this->response->setJSON([
                    'status' => $hd['status'],
                    'messages' => $this->mychat->thread_messages($hd['recid'], (int) $this->request->getGet('after_id'), !$this->myrequest->request_can_chat($hd)),
                ]);

            case 'CHAT-SEND':
                return $this->json($this->mychat->msg_send());

            case 'CHAT-FILE':
                return $this->attachment($this->mychat->attachment($this->request->getGet('id')));

            case 'MAIN':
            default:
                if (drf_is_hr()) {
                    return redirect()->to('myhrrequest');
                }
                return view('request/request-main', [
                    'rows' => $this->myrequest->request_list('mine'),
                    'mode' => 'mine',
                ]);
        }
    }

    // Model results carry 'error' on failure -> 422 so the JS shows it
    private function json(array $result) {
        return $this->response->setStatusCode(isset($result['error']) ? 422 : 200)->setJSON($result);
    }

    // Images open in the browser; other files always download
    private function attachment(?array $file) {
        if ($file === null) {
            return $this->response->setStatusCode(404)->setBody('Attachment not found.');
        }
        // plain-ASCII name for old browsers, the real (UTF-8) name for the rest
        $ascii = preg_replace('/[^\x20-\x7E]|["\\\\]/', '_', $file['orig_name']);
        return $this->response
            ->setHeader('Content-Type', $file['mime_type'])
            ->setHeader('Content-Disposition', ($file['is_image'] ? 'inline' : 'attachment') . '; filename="' . $ascii . '"; filename*=UTF-8\'\'' . rawurlencode($file['orig_name']))
            ->setHeader('X-Content-Type-Options', 'nosniff')
            ->setHeader('Cache-Control', 'private, max-age=86400')
            ->setBody(file_get_contents($file['path']));
    }

    // A signature on a request: ?recid= and who=requester|noted
    private function signature() {
        $hd = $this->myrequest->request_get($this->request->getGet('recid'));
        $file = $hd === null ? '' : $hd[$this->request->getGet('who') === 'noted' ? 'noted_sign' : 'requester_sign'];
        $path = (new \App\Libraries\SignatureStore())->path($file);
        if ($path === null) {
            return $this->response->setStatusCode(404)->setBody('Signature not found.');
        }
        return $this->response
            ->setHeader('Content-Type', 'image/png')
            ->setHeader('X-Content-Type-Options', 'nosniff')
            ->setHeader('Cache-Control', 'private, no-store')
            ->setBody(file_get_contents($path));
    }

    //REQUEST FORM - new, or ?recid= to change one that HR has not decided yet
    private function loadFormView() {

        if (drf_is_hr()) {
            return redirect()->to('myhrrequest');
        }

        $record = null;
        $recid = (int) $this->request->getGet('recid');
        if ($recid > 0) {
            $record = $this->myrequest->request_load($recid);
            if ($record === null || !$this->myrequest->request_is_editable($record['hd'])) {
                return redirect()->to('myrequest?meaction=VIEW&recid=' . $recid);
            }
        }

        $config = config('RequestForms');

        return view('request/request-form', [
            'user' => drf_current_user(),
            'lookups' => $this->myrequest->lookups(),
            'forms' => $config->forms,
            'ltoExpenses' => $config->ltoExpenses,
            'record' => $record,
        ]);
    }

    //REQUEST PAGE - details, status and the conversation with HR
    private function loadRequestView() {

        $record = $this->myrequest->request_load($this->request->getGet('recid'));
        if ($record === null) {
            $this->session->setFlashdata('drf_notice', 'That request was not found.');
            return redirect()->to('/');
        }

        $config = config('RequestForms');

        return view('request/request-view', [
            'record' => $record,
            'form' => $config->forms[$record['hd']['document_id']] ?? null,
            'ltoExpenses' => $config->ltoExpenses,
            'isHr' => drf_is_hr(),
            'isOwner' => $record['hd']['added_by'] === $this->cuser,
            'canEdit' => $this->myrequest->request_is_editable($record['hd']),
            'canApprove' => $this->myrequest->request_can_approve($record['hd']),
            'canChat' => $this->myrequest->request_can_chat($record['hd']),
            'doc' => $this->mydoc->doc_view($record['hd']),
            'me' => (string) $this->cuser,
        ]);
    }

    //SPECIAL ORDER - the page to read and print, or the same document as a Word file
    private function document(bool $asWord) {

        $hd = $this->myrequest->request_get($this->request->getGet('recid'));
        $doc = $hd === null ? null : $this->mydoc->doc_view($hd);
        if ($doc === null) {
            return $this->response->setStatusCode(404)->setBody('This Special Order is not available.');
        }

        if (!$asWord) {
            return view('docs/doc-print', ['hd' => $hd, 'doc' => $doc, 'frame' => $this->request->getGet('frame') === '1']);
        }

        $name = preg_replace('/[^A-Za-z0-9._-]/', '_', 'Special Order ' . $hd['request_no']) . '.doc';
        return $this->response
            ->setHeader('Content-Type', 'application/msword')
            ->setHeader('Content-Disposition', 'attachment; filename="' . $name . '"')
            ->setHeader('Cache-Control', 'private, no-store')
            ->setBody((new \App\Libraries\DocWord())->build('Special Order ' . $hd['request_no'], $doc['doc_html']));
    }

    //PRINT - the filled request form as a PDF
    private function printRequest() {

        $record = $this->myrequest->request_load($this->request->getGet('recid'));
        $config = config('RequestForms');
        if ($record === null || !isset($config->forms[$record['hd']['document_id']])) {
            return $this->response->setStatusCode(404)->setBody('Request not found.');
        }

        $signs = new \App\Libraries\SignatureStore();
        $pdf = new \App\Libraries\RequestPdf($config->forms[$record['hd']['document_id']], $config->ltoExpenses);

        return $this->response
            ->setHeader('Content-Type', 'application/pdf')
            ->setHeader('Content-Disposition', 'inline; filename="' . $record['hd']['request_no'] . '.pdf"')
            ->setHeader('Cache-Control', 'private, no-store')
            ->setBody($pdf->render($record, [
                'requester' => $signs->path($record['hd']['requester_sign']),
                'noted' => $signs->path($record['hd']['noted_sign']),
            ]));
    }

}
