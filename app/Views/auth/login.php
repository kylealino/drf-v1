<?php echo view('templates/drf-header', ['pageTitle' => 'Sign in', 'bare' => true]); ?>
<main class="drf-auth-shell">
    <?= view('auth/auth-brand') ?>

    <form action="<?= site_url('mylogin-auth'); ?>" method="post" class="drf-auth-panel">
        <?= csrf_field(); ?>
        <h2 class="drf-auth-title">Welcome back</h2>
        <p class="drf-auth-sub">Sign in to continue to your requests.</p>

        <?php if (session()->getFlashdata('mesyszicas_memsg_login')): ?>
            <div class="alert alert-danger py-2" role="alert"><i class="ti ti-alert-circle"></i><?= esc(session()->getFlashdata('mesyszicas_memsg_login')) ?></div>
        <?php endif; ?>
        <?php if (session()->getFlashdata('mesyszicas_memsg_registered')): ?>
            <div class="alert alert-success py-2" role="alert"><i class="ti ti-circle-check"></i><?= esc(session()->getFlashdata('mesyszicas_memsg_registered')) ?></div>
        <?php endif; ?>

        <div class="mb-3">
            <label class="form-label" for="MyUsername">Username</label>
            <div class="drf-field">
                <i class="ti ti-user"></i>
                <input type="text" class="form-control" name="MyUsername" id="MyUsername" value="<?= esc(old('MyUsername') ?? '', 'attr') ?>" placeholder="Enter your username" autocomplete="username" required autofocus>
            </div>
        </div>
        <div class="mb-4">
            <label class="form-label" for="MyPassword">Password</label>
            <div class="drf-field">
                <i class="ti ti-lock"></i>
                <input type="password" class="form-control has-toggle" name="MyPassword" id="MyPassword" placeholder="Enter your password" autocomplete="current-password" required>
                <button type="button" class="drf-field-toggle" data-drf-password="#MyPassword" aria-label="Show password" aria-pressed="false"><i class="ti ti-eye"></i></button>
            </div>
        </div>

        <button type="submit" class="btn btn-drf drf-auth-submit">Sign In <i class="ti ti-arrow-right"></i></button>
        <p class="drf-auth-foot">No account yet? <a href="<?= site_url('myregister'); ?>">Register here</a></p>
    </form>
</main>
<?php echo view('templates/drf-footer', ['bare' => true]); ?>
