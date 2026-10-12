<?php

namespace App\Controllers;

class Home extends BaseController
{
    // Log in first; then each role lands on its own module
    public function index()
    {
        if (!session('__xsys_myuserzicas_is_logged__')) {
            return view('auth/login');
        }

        return redirect()->to(drf_is_hr() ? 'myhrrequest' : 'myrequest');
    }

}
