// My Account (account/account-main.php): save account information, change password.
var __mysys_account = new __mysys_account_ent();
function __mysys_account_ent() {
	const app = __mysys_drf;

	// Post a form to myaccount with its meaction; resolves with the server's answer
	function save(form, btn, meaction) {
		if (!form.checkValidity()) {
			form.classList.add('was-validated');
			const first = form.querySelector(':invalid');
			if (first) { first.focus(); }
			return Promise.reject(new Error('Please fill in the required fields.'));
		}
		const data = new FormData(form);
		data.append('meaction', meaction);

		const done = app.busy(btn, 'Saving...');
		return app.post('myaccount', data).finally(done);
	}

	//ACCOUNT INFORMATION - SAVE
	this.__profile_saving = function () {
		const form = document.getElementById('profileForm');
		form.addEventListener('submit', function (e) {
			e.preventDefault();
			save(form, document.getElementById('profileSubmit'), 'PROFILE-SAVE').then(function (res) {
				app.toast(res.message, 'success');
				// the top bar shows the name and office too
				setTimeout(function () { window.location.reload(); }, 900);
			}).catch(function (err) { app.toast(err.message, 'error'); });
		});
	};

	//PASSWORD - CHANGE
	this.__password_saving = function () {
		const form = document.getElementById('passwordForm');
		form.addEventListener('submit', function (e) {
			e.preventDefault();
			if (form.password.value !== form.password_confirm.value) {
				app.toast('The new passwords do not match.', 'error');
				form.password_confirm.focus();
				return;
			}
			save(form, document.getElementById('passwordSubmit'), 'PASSWORD-SAVE').then(function (res) {
				app.toast(res.message, 'success');
				form.reset();
				form.classList.remove('was-validated');
			}).catch(function (err) { app.toast(err.message, 'error'); });
		});
	};
}

document.addEventListener('DOMContentLoaded', function () {
	__mysys_account.__profile_saving();
	__mysys_account.__password_saving();
});
