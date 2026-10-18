<?php
// router.php — for `php -S`. Serves static files (e.g. photos/...) if they
// exist on disk; otherwise delegates to index.php for API routing.

$path = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);

// Serve existing static files directly (photos, favicon, etc.)
if ($path !== '/' && $path !== '/index.php') {
    $candidate = __DIR__ . $path;
    $real      = realpath($candidate);
    // Only serve files actually inside this app directory.
    if ($real && str_starts_with($real, __DIR__ . DIRECTORY_SEPARATOR) && is_file($real)) {
        return false; // let PHP's built-in server handle it
    }
}

require __DIR__ . '/index.php';