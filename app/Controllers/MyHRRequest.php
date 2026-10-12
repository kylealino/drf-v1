<?php

namespace App\Controllers;

class MyHRRequest extends BaseController
{
    protected $myrequest;

    public function __construct()
    {
        $this->request = \Config\Services::request();
        $this->myrequest = model('App\Models\MyRequestModel');
    }

    // HR desk: every request that reached HR - signed by the requester and
    // approved by its "Noted by" signatory. Opening one goes to the shared request page
    // (myrequest?meaction=VIEW) where HR also updates the status.
    public function index() {

        if (!drf_is_hr()) {
            return redirect()->to('myrequest');
        }

        $meaction = $this->request->getPostGet('meaction');

        switch ($meaction) {
            case 'STATUS-SAVE':
                if (strtolower($this->request->getMethod()) !== 'post') {
                    return $this->response->setStatusCode(405)->setJSON(['error' => 'Not allowed.']);
                }
                $result = $this->myrequest->status_save();
                return $this->response->setStatusCode(isset($result['error']) ? 422 : 200)->setJSON($result);

            case 'MAIN':
            default:
                return view('request/request-main', [
                    'rows' => $this->myrequest->request_list('hr'),
                    'mode' => 'hr',
                ]);
        }
    }

}
