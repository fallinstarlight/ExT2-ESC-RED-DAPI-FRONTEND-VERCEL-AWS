<?php
// router.php — for `php -S`. Serves /photos/** as static files, else -> index.php.
$path = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);

$staticDirs = ['/photos/', '/favicon.ico'];
$isStatic = false;
foreach ($staticDirs as $d) {
    if (str_starts_with($path, $d)) { $isStatic = true; break; }
}

if ($isStatic) {
    $real = realpath(__DIR__ . $path);
    if ($real && str_starts_with($real, __DIR__ . DIRECTORY_SEPARATOR) && is_file($real)) {
        return false; // let PHP's built-in server stream the file
    }
    http_response_code(404);
    exit;
}

require __DIR__ . '/index.php';