<?php

namespace App\Controllers;

class MyApproval extends BaseController
{
    protected $myrequest;

    public function __construct()
    {
        $this->request = \Config\Services::request();
        $this->myrequest = model('App\Models\MyRequestModel');
    }

    // For My Approval: requests that name you as "Noted by". Opening one goes
    // to the shared request page (myrequest?meaction=VIEW) where you return it
    // to the requester, or sign and approve it - which submits it to HR.
    public function index() {

        if (drf_is_hr()) {
            return redirect()->to('myhrrequest');
        }

        $meaction = $this->request->getPostGet('meaction');

        switch ($meaction) {
            case 'APPROVAL-SAVE':
                if (strtolower($this->request->getMethod()) !== 'post') {
                    return $this->response->setStatusCode(405)->setJSON(['error' => 'Not allowed.']);
                }
                $result = $this->myrequest->approval_save();
                return $this->response->setStatusCode(isset($result['error']) ? 422 : 200)->setJSON($result);

            case 'MAIN':
            default:
                return view('request/request-main', [
                    'rows' => $this->myrequest->request_list('approval'),
                    'mode' => 'approval',
                ]);
        }
    }

}
