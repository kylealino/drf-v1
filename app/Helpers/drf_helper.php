<?php

/**
 * Who is signed in and what they may see. Roles live in tbl_roles
 * (ids in Config\RequestForms). Autoloaded app-wide via Config\Autoload::$helpers.
 */

if (!function_exists('drf_current_user')) {
    /**
     * The logged-in user's account, loaded once per request.
     * Every key is present (blank) when nobody is signed in.
     */
    function drf_current_user(): array
    {
        static $user = null;

        if ($user !== null) {
            return $user;
        }

        $user = ['username' => '', 'full_name' => '', 'position' => '', 'division' => '', 'section' => '', 'role_id' => 0, 'role_name' => ''];

        $username = session('__xsys_myuserzicas__');
        if (empty($username)) {
            return $user;
        }

        $row = \Config\Database::connect()->query("
            SELECT u.`username`, u.`full_name`, u.`position`, u.`division`, u.`section`, u.`role_id`, COALESCE(r.`role_name`, '') role_name
            FROM myua_user u
            LEFT JOIN tbl_roles r ON r.`recid` = u.`role_id`
            WHERE u.`username` = ? AND u.`is_active` = 1
            LIMIT 1
        ", [$username])->getRowArray();

        if ($row) {
            $row['role_id'] = (int) $row['role_id'];
            $user = $row;
        }

        return $user;
    }
}

if (!function_exists('drf_is_hr')) {
    function drf_is_hr(): bool
    {
        return drf_current_user()['role_id'] === \Config\RequestForms::ROLE_HR;
    }
}

if (!function_exists('drf_approval_count')) {
    /**
     * Requests waiting for the logged-in user's "Noted by" signature (topbar badge).
     */
    function drf_approval_count(): int
    {
        $username = drf_current_user()['username'];
        if ($username === '' || drf_is_hr()) {
            return 0;
        }

        $row = \Config\Database::connect()->query("
            SELECT COUNT(*) total FROM tbl_request_hd WHERE `noted_by_user` = ? AND `status` = ?
        ", [$username, \Config\RequestForms::STATUS_FOR_APPROVAL])->getRowArray();

        return (int) ($row['total'] ?? 0);
    }
}

if (!function_exists('drf_initials')) {
    /**
     * "DELA CRUZ, JUAN M." -> "JD", "HR Personnel" -> "HP"
     */
    function drf_initials(string $name): string
    {
        $parts = array_map('trim', explode(',', $name, 2));
        // staff names are stored surname first
        $words = preg_split('/\s+/', trim(count($parts) === 2 ? $parts[1] . ' ' . $parts[0] : $parts[0]), -1, PREG_SPLIT_NO_EMPTY);
        if (empty($words)) {
            return '?';
        }
        $first = mb_substr($words[0], 0, 1);
        $last = count($words) > 1 ? mb_substr($words[count($words) - 1], 0, 1) : '';
        return mb_strtoupper($first . $last);
    }
}

if (!function_exists('drf_status_tone')) {
    /**
     * The drf.css tone class of a request status.
     */
    function drf_status_tone(string $status): string
    {
        return [
            \Config\RequestForms::STATUS_FOR_APPROVAL => 'tone-amber',
            \Config\RequestForms::STATUS_RETURNED => 'tone-red',
            \Config\RequestForms::STATUS_PENDING => 'tone-slate',
            \Config\RequestForms::STATUS_COMPLIANCE => 'tone-indigo',
            \Config\RequestForms::STATUS_APPROVED => 'tone-green',
            \Config\RequestForms::STATUS_DENIED => 'tone-red',
        ][$status] ?? 'tone-slate';
    }
}

if (!function_exists('drf_money')) {
    /**
     * Blank for "no amount", otherwise 1,234.50
     */
    function drf_money($value): string
    {
        return $value === null || $value === '' ? '' : number_format((float) $value, 2);
    }
}

if (!function_exists('drf_doc_fill')) {
    /**
     * A value on a Special Order template, or - when the request did not
     * give one - a marked placeholder for HR to type over in the editor.
     */
    function drf_doc_fill($value, string $hint): string
    {
        $value = trim((string) $value);
        return $value !== '' ? nl2br(esc($value)) : '<span class="doc-fill">[' . esc($hint) . ']</span>';
    }
}

if (!function_exists('drf_doc_so_no')) {
    /**
     * "PTC-0012" once HR has entered the S.O. number, otherwise "PTC-_______".
     */
    function drf_doc_so_no(string $prefix, string $soNo): string
    {
        $soNo = trim($soNo);
        if ($soNo === '') {
            return esc($prefix) . '_______';
        }
        // HR may type the number with or without the series prefix
        return esc(stripos($soNo, rtrim($prefix, '- ')) === 0 ? $soNo : $prefix . $soNo);
    }
}
