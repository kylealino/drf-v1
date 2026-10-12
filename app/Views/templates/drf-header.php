<?php
// Shared page top. Pass 'pageTitle'; 'bare' => true for the log in / register
// pages (no topbar), 'nav' => the topbar link to mark as current.
$user = drf_current_user();
$is_hr = drf_is_hr();
$page_title = $pageTitle ?? 'Requests';
$bare = !empty($bare);
$nav = $nav ?? '';
$approvals = $bare ? 0 : drf_approval_count();
$org_unit = implode(' · ', array_filter([$user['division'], $user['section']], fn ($v) => $v !== ''));
?>
<!DOCTYPE html>
<html lang="en" dir="ltr" data-bs-theme="light">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta name="drf-siteurl" content="<?= esc(site_url(), 'attr') ?>" />
  <meta name="drf-csrf" content="<?= csrf_hash() ?>" />
  <link rel="shortcut icon" type="image/png" href="<?=base_url('assets/images/logos/fnrilogo.png')?>" />
  <title><?= esc($page_title . ' · Special Order Request Form') ?></title>
  <link rel="stylesheet" href="<?=base_url('assets/css/styles.css')?>" />
  <link rel="stylesheet" href="<?=base_url('assets/css/drf.css?v=12')?>" />
</head>
<body class="drf-body<?= $bare ? ' drf-auth' : '' ?>">
<?php if (!$bare): ?>
  <header class="drf-topbar">
    <a class="drf-brand" href="<?= site_url(); ?>">
      <img src="<?=base_url('assets/images/logos/fnrilogo.png')?>" alt="" />
      <span class="drf-brand-text">
        <strong>Special Order Request Form</strong>
        <small><?= $is_hr ? 'HR Desk' : 'Document Request Portal' ?></small>
      </span>
    </a>

    <nav class="drf-topnav" aria-label="Main">
      <?php if ($is_hr): ?>
        <a class="<?= $nav === 'list' ? 'active' : '' ?>" href="<?= site_url('myhrrequest'); ?>"><i class="ti ti-inbox"></i> All Requests</a>
      <?php else: ?>
        <a class="<?= $nav === 'list' ? 'active' : '' ?>" href="<?= site_url('myrequest'); ?>"><i class="ti ti-files"></i> My Requests</a>
        <a class="<?= $nav === 'approval' ? 'active' : '' ?>" href="<?= site_url('myapproval'); ?>"><i class="ti ti-writing-sign"></i> For My Approval<?php if ($approvals > 0): ?> <span class="drf-unread"><?= $approvals > 99 ? '99+' : $approvals ?></span><?php endif; ?></a>
        <a class="<?= $nav === 'form' ? 'active' : '' ?>" href="<?= site_url('myrequest?meaction=FORM'); ?>"><i class="ti ti-plus"></i> New Request</a>
      <?php endif; ?>
    </nav>

    <div class="dropdown ms-auto">
      <button type="button" class="drf-profile" data-bs-toggle="dropdown" data-bs-offset="0,8" aria-expanded="false">
        <span class="drf-avatar"><?= esc(drf_initials($user['full_name'])) ?></span>
        <span class="drf-profile-text d-none d-xl-flex">
          <strong><?= esc($user['full_name']) ?></strong>
          <small><?= esc($user['role_name']) ?></small>
        </span>
        <i class="ti ti-chevron-down"></i>
      </button>

      <div class="dropdown-menu dropdown-menu-end drf-profile-menu">
        <div class="drf-profile-head">
          <div class="drf-profile-name"><?= esc($user['full_name']) ?></div>
          <div class="drf-profile-meta">@<?= esc($user['username']) ?> · <?= esc($user['role_name']) ?></div>
          <?php if ($org_unit !== ''): ?>
            <div class="drf-profile-meta"><?= esc($org_unit) ?></div>
          <?php endif; ?>
        </div>
        <div class="drf-profile-foot">
          <a class="btn btn-sm btn-drf-ghost w-100 py-2 mb-2<?= $nav === 'account' ? ' active' : '' ?>" href="<?= site_url('myaccount'); ?>"><i class="ti ti-user-circle me-1"></i>My Account</a>
          <form action="<?= site_url('mylogout'); ?>" method="post">
            <?= csrf_field(); ?>
            <button type="submit" class="btn btn-sm btn-drf-ghost w-100 py-2"><i class="ti ti-logout me-1"></i>Log out</button>
          </form>
        </div>
      </div>
    </div>
  </header>

  <main class="drf-content">
<?php endif; ?>
