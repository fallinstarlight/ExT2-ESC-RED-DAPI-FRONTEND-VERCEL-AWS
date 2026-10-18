<?php
// Artists & People API
declare(strict_types=1);
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Accept');
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}
require __DIR__ . '/db.php';

$method = $_SERVER['REQUEST_METHOD'];
$path   = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
$path   = rtrim($path, '/');

if ($method !== 'GET') {
    json_error('Method not allowed', 405);
}

try {
    // GET /artists?q=&genre=&type=&active=
    if ($path === '/artists') {
        $rows = call_proc('sp_search_artists', [
            $_GET['q']      ?? null,
            $_GET['genre']  ?? null,
            $_GET['type']   ?? null,
            isset($_GET['active']) ? (int)(bool)$_GET['active'] : null,
        ]);
        json_response($rows);
    }

    // GET /artists/{id}
    if (preg_match('#^/artists/(\d+)$#', $path, $m)) {
        $rows = call_proc('sp_get_artist_by_id', [(int)$m[1]]);
        $rows ? json_response($rows[0]) : json_error('Artist not found', 404);
    }

    // GET /artists/{id}/members
    if (preg_match('#^/artists/(\d+)/members$#', $path, $m)) {
        json_response(call_proc('sp_get_band_members', [(int)$m[1]]));
    }

    // GET /people?q=
    if ($path === '/people') {
        json_response(call_proc('sp_search_people', [$_GET['q'] ?? null]));
    }

    // GET /people/{id}
    if (preg_match('#^/people/(\d+)$#', $path, $m)) {
        $rows = call_proc('sp_get_person_by_id', [(int)$m[1]]);
        $rows ? json_response($rows) : json_error('Person not found', 404);
    }

    // GET /health
    if ($path === '/health') {
        db()->query('SELECT 1');
        json_response(['status' => 'ok']);
    }

    json_error('Not found', 404);
} catch (Throwable $e) {
    json_error('Server error: ' . $e->getMessage(), 500);
}