<?php
declare(strict_types=1);

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Accept');
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') { http_response_code(204); exit; }

require __DIR__ . '/db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'GET') json_error('Method not allowed', 405);

$path = rtrim(parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH), '/') ?: '/';

try {
    // GET /artists?q=&genre=&type=&active=
    if ($path === '/artists') {
        $rows = call_proc('sp_search_artists', [
            $_GET['q']      ?? null,
            $_GET['genre']  ?? null,
            $_GET['type']   ?? null,
            isset($_GET['active']) ? (int)(bool)$_GET['active'] : null,
        ]);
        json_response(map_photo_urls($rows, 'photo_url', 'photos/artists/'));
    }

    // GET /artists/{id}
    if (preg_match('#^/artists/(\d+)$#', $path, $m)) {
        $rows = call_proc('sp_get_artist_by_id', [(int)$m[1]]);
        if (!$rows) json_error('Artist not found', 404);
        $rows = map_photo_urls($rows, 'photo_url', 'photos/artists/');
        json_response($rows[0]);
    }

    // GET /artists/{id}/members
    if (preg_match('#^/artists/(\d+)/members$#', $path, $m)) {
        $rows = call_proc('sp_get_band_members', [(int)$m[1]]);
        json_response(map_photo_urls($rows, 'photo_url', 'photos/artists/'));
    }

    // GET /people?q=
    if ($path === '/people') {
        $rows = call_proc('sp_search_people', [$_GET['q'] ?? null]);
        json_response(map_photo_urls($rows, 'photo_url', 'photos/artists/'));
    }

    // GET /people/{id}
    if (preg_match('#^/people/(\d+)$#', $path, $m)) {
        $rows = call_proc('sp_get_person_by_id', [(int)$m[1]]);
        if (!$rows) json_error('Person not found', 404);
        json_response(map_photo_urls($rows, 'photo_url', 'photos/artists/'));
    }

    if ($path === '/health') {
        db()->query('SELECT 1');
        json_response(['status' => 'ok']);
    }

    json_error('Not found', 404);
} catch (Throwable $e) {
    json_error('Server error: ' . $e->getMessage(), 500);
}