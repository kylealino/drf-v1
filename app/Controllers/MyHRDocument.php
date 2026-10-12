<?php

namespace App\Controllers;

class MyHRDocument extends BaseController
{
    protected $mydoc;
    protected $myrequest;

    public function __construct()
    {
        $this->request = \Config\Services::request();
        $this->mydoc = model('App\Models\MyRequestDocModel');
        $this->myrequest = model('App\Models\MyRequestModel');
    }

    // HR document editor: the Special Order of a request, started from the
    // official template, edited on the page and released to the requester.
    // Viewing/printing the result is shared: myrequest?meaction=DOC.
    public function index() {

        if (!drf_is_hr()) {
            return redirect()->to('myrequest');
        }

        $meaction = $this->request->getPostGet('meaction');
        $saving = ['DOC-START', 'DOC-SAVE', 'DOC-RELEASE', 'DOC-WITHDRAW'];

        // changes only ever come from a form post
        if (in_array($meaction, $saving, true) && strtolower($this->request->getMethod()) !== 'post') {
            return $this->response->setStatusCode(405)->setJSON(['error' => 'Not allowed.']);
        }

        switch ($meaction) {
            case 'DOC-START':
                return $this->json($this->mydoc->doc_start());

            case 'DOC-SAVE':
                return $this->json($this->mydoc->doc_save());

            case 'DOC-RELEASE':
                return $this->json($this->mydoc->doc_release());

            case 'DOC-WITHDRAW':
                return $this->json($this->mydoc->doc_withdraw());

            case 'MAIN':
            default:
                return $this->loadEditorView();
        }
    }

    // Model results carry 'error' on failure -> 422 so the JS shows it
    private function json(array $result) {
        return $this->response->setStatusCode(isset($result['error']) ? 422 : 200)->setJSON($result);
    }

    private function loadEditorView() {

        $hd = $this->myrequest->request_get($this->request->getGet('recid'));
        if ($hd === null) {
            session()->setFlashdata('drf_notice', 'That request was not found.');
            return redirect()->to('myhrrequest');
        }

        $config = config('DocumentTemplates');

        return view('docs/doc-editor', [
            'hd' => $hd,
            'doc' => $this->mydoc->doc_get($hd['recid']),
            'templates' => $config->templates,
            'suggested' => $config->suggested($hd['document_id']),
        ]);
    }

}
