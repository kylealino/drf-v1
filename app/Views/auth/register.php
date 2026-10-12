<?php echo view('templates/drf-header', ['pageTitle' => 'Register', 'bare' => true]); ?>
<main class="drf-auth-shell is-wide">
    <?= view('auth/auth-brand') ?>

    <form action="<?= site_url('myregister'); ?>" method="post" class="drf-auth-panel">
        <?= csrf_field(); ?>
        <h2 class="drf-auth-title">Create your account</h2>
        <p class="drf-auth-sub">Register once to file and sign your requests online.</p>

        <?php if (session()->getFlashdata('mesyszicas_memsg_register')): ?>
            <div class="alert alert-danger py-2" role="alert"><i class="ti ti-alert-circle"></i><?= esc(session()->getFlashdata('mesyszicas_memsg_register')) ?></div>
        <?php endif; ?>

        <div class="row g-3">
            <div class="col-12">
                <label class="form-label" for="full_name">Full Name <span class="drf-req">*</span></label>
                <input type="text" class="form-control" name="full_name" id="full_name" value="<?= esc(old('full_name') ?? '', 'attr') ?>" maxlength="100" placeholder="As it should appear on your requests" required autofocus>
            </div>
            <div class="col-md-6">
                <label class="form-label" for="division">Division <span class="drf-req">*</span></label>
                <select class="form-select" name="division" id="division" required>
                    <option value="">Select Division</option>
                    <?php foreach ($lookups['divisions'] as $d): ?>
                        <option value="<?= esc($d['division_id'], 'attr') ?>" <?= old('division') === $d['division_id'] ? 'selected' : '' ?>><?= esc($d['division_name']) ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
            <div class="col-md-6">
                <label class="form-label" for="section">Section <span class="drf-req">*</span></label>
                <select class="form-select" name="section" id="section" data-drf-sections="#division" required>
                    <option value="">Select Section</option>
                    <?php foreach ($lookups['sections'] as $s): ?>
                        <option value="<?= esc($s['section_id'], 'attr') ?>" data-division="<?= esc($s['division_id'], 'attr') ?>" <?= old('division') === $s['division_id'] && old('section') === $s['section_id'] ? 'selected' : '' ?>><?= esc($s['section_name']) ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
            <div class="col-md-6">
                <label class="form-label" for="position">Position</label>
                <input type="text" class="form-control" name="position" id="position" value="<?= esc(old('position') ?? '', 'attr') ?>" maxlength="100">
            </div>
            <div class="col-md-6">
                <label class="form-label" for="username">Username <span class="drf-req">*</span></label>
                <input type="text" class="form-control" name="username" id="username" value="<?= esc(old('username') ?? '', 'attr') ?>" minlength="4" maxlength="50" pattern="[A-Za-z0-9._\-]+" autocomplete="username" required>
            </div>
            <div class="col-md-6">
                <label class="form-label" for="password">Password <span class="drf-req">*</span></label>
                <input type="password" class="form-control" name="password" id="password" minlength="6" autocomplete="new-password" required>
            </div>
            <div class="col-md-6">
                <label class="form-label" for="password_confirm">Confirm Password <span class="drf-req">*</span></label>
                <input type="password" class="form-control" name="password_confirm" id="password_confirm" minlength="6" autocomplete="new-password" required>
            </div>
        </div>

        <button type="submit" class="btn btn-drf drf-auth-submit mt-4">Create Account <i class="ti ti-arrow-right"></i></button>
        <p class="drf-auth-foot">Already registered? <a href="<?= site_url(); ?>">Sign in</a></p>
    </form>
</main>
<?php echo view('templates/drf-footer', ['bare' => true]); ?>
