<?php
// My Account: the signed-in user's own information and password.
echo view('templates/drf-header', ['pageTitle' => 'My Account', 'nav' => 'account']);
?>
<div class="drf-wrap">
    <div class="drf-page-head">
        <div>
            <h1 class="drf-page-title">My Account</h1>
            <p class="drf-page-sub">Your name and office as they appear on new requests, and your password.</p>
        </div>
    </div>

    <div class="row g-4">
        <div class="col-lg-7">
            <div class="drf-card">
                <div class="drf-card-head"><h2 class="drf-card-title">Account information</h2></div>
                <form class="drf-card-body" id="profileForm" novalidate>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label" for="username">Username</label>
                            <input type="text" class="form-control" id="username" value="<?= esc($account['username'], 'attr') ?>" readonly>
                            <div class="drf-hint mt-1">Your username cannot be changed.</div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label" for="role_name">Role</label>
                            <input type="text" class="form-control" id="role_name" value="<?= esc($account['role_name'], 'attr') ?>" readonly>
                        </div>
                        <div class="col-12">
                            <label class="form-label" for="full_name">Full Name <span class="drf-req">*</span></label>
                            <input type="text" class="form-control" name="full_name" id="full_name" value="<?= esc($account['full_name'], 'attr') ?>" maxlength="100" required>
                            <div class="invalid-feedback">Full name is required.</div>
                        </div>
                        <div class="col-12">
                            <label class="form-label" for="position">Position</label>
                            <input type="text" class="form-control" name="position" id="position" value="<?= esc($account['position'], 'attr') ?>" maxlength="100">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label" for="division">Division <span class="drf-req">*</span></label>
                            <select class="form-select" name="division" id="division" required>
                                <option value="">Select Division</option>
                                <?php foreach ($lookups['divisions'] as $d): ?>
                                    <option value="<?= esc($d['division_id'], 'attr') ?>" <?= $account['division'] === $d['division_id'] ? 'selected' : '' ?>><?= esc($d['division_name']) ?></option>
                                <?php endforeach; ?>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label" for="section">Section <span class="drf-req">*</span></label>
                            <select class="form-select" name="section" id="section" data-drf-sections="#division" required>
                                <option value="">Select Section</option>
                                <?php foreach ($lookups['sections'] as $s): ?>
                                    <option value="<?= esc($s['section_id'], 'attr') ?>" data-division="<?= esc($s['division_id'], 'attr') ?>" <?= $account['division'] === $s['division_id'] && $account['section'] === $s['section_id'] ? 'selected' : '' ?>><?= esc($s['section_name']) ?></option>
                                <?php endforeach; ?>
                            </select>
                        </div>
                    </div>
                    <p class="drf-hint mt-3 mb-0">Requests you already filed keep the name they were signed with. People naming you under "Noted by" will see your new name.</p>
                    <div class="drf-form-foot">
                        <button type="submit" class="btn btn-drf px-4 py-2" id="profileSubmit">Save Changes</button>
                    </div>
                </form>
            </div>
        </div>

        <div class="col-lg-5">
            <div class="drf-card">
                <div class="drf-card-head"><h2 class="drf-card-title">Change password</h2></div>
                <form class="drf-card-body" id="passwordForm" novalidate>
                    <?php // lets password managers tie the new password to the right account ?>
                    <input type="text" value="<?= esc($account['username'], 'attr') ?>" autocomplete="username" hidden>

                    <?php foreach ([
                        ['current_password', 'Current password', 'current-password'],
                        ['password', 'New password', 'new-password'],
                        ['password_confirm', 'Confirm new password', 'new-password'],
                    ] as [$name, $label, $autocomplete]): ?>
                    <div class="mb-3">
                        <label class="form-label" for="<?= $name ?>"><?= $label ?> <span class="drf-req">*</span></label>
                        <div class="drf-field">
                            <i class="ti ti-lock"></i>
                            <input type="password" class="form-control has-toggle" name="<?= $name ?>" id="<?= $name ?>" autocomplete="<?= $autocomplete ?>" <?= $name === 'current_password' ? '' : 'minlength="' . \App\Models\MyAccountModel::MIN_PASSWORD . '"' ?> required>
                            <button type="button" class="drf-field-toggle" data-drf-password="#<?= $name ?>" aria-label="Show password" aria-pressed="false"><i class="ti ti-eye"></i></button>
                        </div>
                    </div>
                    <?php endforeach; ?>
                    <p class="drf-hint mb-0">At least <?= \App\Models\MyAccountModel::MIN_PASSWORD ?> characters. You stay signed in on this device.</p>
                    <div class="drf-form-foot">
                        <button type="submit" class="btn btn-drf px-4 py-2" id="passwordSubmit">Change Password</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<?php echo view('templates/drf-footer', ['scripts' => ['account/myaccount.js?v=1']]); ?>
