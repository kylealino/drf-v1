<?php
namespace App\Models;
use CodeIgniter\Model;

class MyAccountModel extends Model
{

	protected $db;
	protected $session;
	protected $request;
	protected $cuser;

	public const MIN_PASSWORD = 6;

	public function __construct(){
		parent::__construct();
		$this->session = session();
		$this->request = \Config\Services::request();
		$this->db = \Config\Database::connect();
		$this->cuser = $this->session->get('__xsys_myuserzicas__');
	}

	//ACCOUNT - the logged-in user's own row (null if the account is gone or switched off)
	public function account_get() {
		return $this->db->query("
			SELECT u.`recid`, u.`username`, u.`hash_password`, u.`full_name`, u.`position`, u.`division`, u.`section`, u.`added_at`,
				COALESCE(r.`role_name`, '') role_name
			FROM myua_user u
			LEFT JOIN tbl_roles r ON r.`recid` = u.`role_id`
			WHERE u.`username` = ? AND u.`is_active` = 1
			LIMIT 1
		", [(string) $this->cuser])->getRowArray();
	}

	//ACCOUNT - SAVE name, position, division and section. The username stays:
	// requests, signatures and messages are filed under it.
	public function profile_save() {
		$full_name = trim((string) $this->request->getPost('full_name'));
		$position = trim((string) $this->request->getPost('position'));
		$division = (string) $this->request->getPost('division');
		$section = (string) $this->request->getPost('section');

		$account = $this->account_get();
		if (!$account) {
			return ['error' => 'Your session has ended. Please sign in again.'];
		}
		if ($full_name === '' || mb_strlen($full_name) > 100) {
			return ['error' => 'Full name is required (100 characters max).'];
		}
		if (mb_strlen($position) > 100) {
			return ['error' => 'Position is too long (100 characters max).'];
		}
		if (!model('App\Models\MyRequestModel')->section_exists($division, $section)) {
			return ['error' => 'Choose your division and section.'];
		}

		$this->db->query("
			UPDATE myua_user SET `full_name` = ?, `position` = ?, `division` = ?, `section` = ? WHERE `recid` = ?
		", [$full_name, $position, $division, $section, $account['recid']]);

		return ['ok' => true, 'message' => 'Your account information was saved.'];
	}

	//ACCOUNT - CHANGE PASSWORD (the current one is asked again, so a borrowed
	// session cannot lock the owner out)
	public function password_save() {
		$current = (string) $this->request->getPost('current_password');
		$password = (string) $this->request->getPost('password');
		$password_confirm = (string) $this->request->getPost('password_confirm');

		$account = $this->account_get();
		if (!$account) {
			return ['error' => 'Your session has ended. Please sign in again.'];
		}
		if (!password_verify($current, $account['hash_password'])) {
			return ['error' => 'Your current password is not correct.'];
		}
		if (strlen($password) < self::MIN_PASSWORD) {
			return ['error' => 'The new password must be at least ' . self::MIN_PASSWORD . ' characters.'];
		}
		if ($password !== $password_confirm) {
			return ['error' => 'The new passwords do not match.'];
		}
		if ($password === $current) {
			return ['error' => 'Choose a password different from your current one.'];
		}

		$this->db->query("
			UPDATE myua_user SET `hash_password` = ? WHERE `recid` = ?
		", [password_hash($password, PASSWORD_DEFAULT), $account['recid']]);

		// a fresh session id for the device that made the change
		$this->session->regenerate(true);

		return ['ok' => true, 'message' => 'Your password was changed.'];
	}

} //end main class
