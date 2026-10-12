<?php // Left panel of the log in / register pages: what this portal is for. ?>
<aside class="drf-auth-brand">
    <span class="drf-auth-grid" aria-hidden="true"></span>

    <div class="drf-auth-logo">
        <img src="<?=base_url('assets/images/logos/fnrilogo.png')?>" alt="" />
        <span>Document Request Portal</span>
    </div>

    <div>
        <h1 class="drf-auth-headline">Special Order Request Form</h1>
        <p class="drf-auth-lead">File, sign and follow your special order requests with the Human Resource Management Section.</p>

        <ul class="drf-auth-steps">
            <li><i class="ti ti-file-text"></i> File your request and sign it online</li>
            <li><i class="ti ti-writing-sign"></i> Your chief notes and approves it</li>
            <li><i class="ti ti-checks"></i> HR processes it and keeps you posted</li>
        </ul>
    </div>

    <div class="drf-auth-note">&copy; <?= date('Y') ?> Human Resource Management Section</div>
</aside>
