<?php

namespace App\Controllers;

class MyLogIn extends BaseController
{
    protected $db;
    protected $session;

    public function __construct()
    {
        $this->request = \Config\Services::request();
        $this->db = \Config\Database::connect();
        $this->session = session();
    }

    public function auth()
    {
        $meusername = trim((string) $this->request->getPost('MyUsername'));
        $password = (string) $this->request->getPost('MyPassword');

        $data = $this->db->query("
            SELECT `username`, `hash_password` FROM myua_user WHERE `username` = ? AND `is_active` = 1 LIMIT 1
        ", [$meusername])->getRowArray();

        // same message either way, so the form does not tell which usernames exist
        if (!$data || !password_verify($password, $data['hash_password'])) {
            $this->session->setFlashdata('mesyszicas_memsg_login', 'Wrong username or password.');
            return redirect()->to('/')->withInput();
        }

        $this->session->regenerate(true);
        $this->session->set([
            '__xsys_myuserzicas_is_logged__' => true,
            '__xsys_myuserzicas__' => $data['username'],
        ]);

        return redirect()->to('/');
    }

    public function logout()
    {
        $this->session->destroy();
        return redirect()->to('/');
    }

    public function register()
    {
        if (session('__xsys_myuserzicas_is_logged__')) {
            return redirect()->to('/');
        }

        return view('auth/register', ['lookups' => model('App\Models\MyRequestModel')->org_lookups()]);
    }

    //REGISTER - SAVE (new accounts are always requesters; HR accounts are added in the database)
    public function register_save()
    {
        $full_name = trim((string) $this->request->getPost('full_name'));
        $username = trim((string) $this->request->getPost('username'));
        $position = trim((string) $this->request->getPost('position'));
        $division = (string) $this->request->getPost('division');
        $section = (string) $this->request->getPost('section');
        $password = (string) $this->request->getPost('password');
        $password_confirm = (string) $this->request->getPost('password_confirm');

        $error = '';
        if ($full_name === '' || mb_strlen($full_name) > 100) {
            $error = 'Full name is required (100 characters max).';
        } elseif (!preg_match('/^[A-Za-z0-9._-]{4,50}$/', $username)) {
            $error = 'Username must be 4-50 characters: letters, numbers, dot, dash or underscore.';
        } elseif (mb_strlen($position) > 100) {
            $error = 'Position is too long (100 characters max).';
        } elseif (!model('App\Models\MyRequestModel')->section_exists($division, $section)) {
            $error = 'Choose your division and section.';
        } elseif (strlen($password) < 6) {
            $error = 'Password must be at least 6 characters.';
        } elseif ($password !== $password_confirm) {
            $error = 'The passwords do not match.';
        } elseif ($this->db->query("SELECT `recid` FROM myua_user WHERE `username` = ? LIMIT 1", [$username])->getRowArray()) {
            $error = 'That username is already taken.';
        }

        if ($error !== '') {
            $this->session->setFlashdata('mesyszicas_memsg_register', $error);
            return redirect()->to('myregister')->withInput();
        }

        $this->db->query("
            INSERT INTO myua_user (`username`, `hash_password`, `full_name`, `division`, `section`, `position`, `role_id`, `added_by`)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        ", [$username, password_hash($password, PASSWORD_DEFAULT), $full_name, $division, $section, $position, \Config\RequestForms::ROLE_REQUESTER, $username]);

        $this->session->setFlashdata('mesyszicas_memsg_registered', 'Account created. You can sign in now.');
        return redirect()->to('/');
    }
}
