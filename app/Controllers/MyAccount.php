<?php

namespace App\Controllers;

class MyAccount extends BaseController
{
    protected $myaccount;

    public function __construct()
    {
        $this->request = \Config\Services::request();
        $this->myaccount = model('App\Models\MyAccountModel');
    }

    // My Account: every signed-in user (requesters and HR alike) changes their
    // own name, position, office and password here.
    public function index() {

        $meaction = $this->request->getPostGet('meaction');

        // saving only ever comes from a form post
        if (in_array($meaction, ['PROFILE-SAVE', 'PASSWORD-SAVE'], true) && strtolower($this->request->getMethod()) !== 'post') {
            return $this->response->setStatusCode(405)->setJSON(['error' => 'Not allowed.']);
        }

        switch ($meaction) {
            case 'PROFILE-SAVE':
                return $this->json($this->myaccount->profile_save());

            case 'PASSWORD-SAVE':
                return $this->json($this->myaccount->password_save());

            case 'MAIN':
            default:
                $account = $this->myaccount->account_get();
                if (!$account) {
                    return redirect()->to('/');
                }
                unset($account['hash_password']);

                return view('account/account-main', [
                    'account' => $account,
                    'lookups' => model('App\Models\MyRequestModel')->org_lookups(),
                ]);
        }
    }

    // Model results carry 'error' on failure -> 422 so the JS shows it
    private function json(array $result) {
        return $this->response->setStatusCode(isset($result['error']) ? 422 : 200)->setJSON($result);
    }

}
