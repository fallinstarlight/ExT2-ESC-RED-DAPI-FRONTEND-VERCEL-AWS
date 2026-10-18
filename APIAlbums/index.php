<?php
declare(strict_types=1);

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Accept');
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') { http_response_code(204); exit; }

require __DIR__ . '/db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'GET') json_error('Method not allowed', 405);

$path = rtrim(parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH), '/') ?: '/';

function int_or_null($v)   { return ($v === null || $v === '') ? null : (int)$v; }
function float_or_null($v) { return ($v === null || $v === '') ? null : (float)$v; }

try {
    // GET /albums?name=&year=&genre=&artist=&min_rating=&max_rating=
    // -> uses sp_search_albums with any combination of filters.
    // The frontend uses "artist=" specifically to answer
    // "show me all albums by this artist".
    if ($path === '/albums') {
        $rows = call_proc('sp_search_albums', [
            $_GET['name']       ?? null,
            int_or_null($_GET['year']       ?? null),
            $_GET['genre']      ?? null,
            $_GET['artist']     ?? null,   // <-- albums by artist
            float_or_null($_GET['min_rating'] ?? null),
            float_or_null($_GET['max_rating'] ?? null),
        ]);
        json_response(map_photo_urls($rows, 'cover_url', 'photos/albums/'));
    }

    // GET /albums/{id}
    if (preg_match('#^/albums/(\d+)$#', $path, $m)) {
        $rows = call_proc('sp_get_album_by_id', [(int)$m[1]]);
        if (!$rows) json_error('Album not found', 404);
        $rows = map_photo_urls($rows, 'cover_url', 'photos/albums/');
        json_response($rows[0]);
    }

    // GET /albums/{id}/tracks
    if (preg_match('#^/albums/(\d+)/tracks$#', $path, $m)) {
        $rows = call_proc('sp_get_tracks_by_album', [(int)$m[1]]);
        json_response(map_photo_urls($rows, 'cover_url', 'photos/albums/'));
    }

    // GET /tracks?name=&album=&artist=&year=&genre=
    if ($path === '/tracks') {
        $rows = call_proc('sp_search_tracks', [
            $_GET['name']   ?? null,
            $_GET['album']  ?? null,
            $_GET['artist'] ?? null,
            int_or_null($_GET['year'] ?? null),
            $_GET['genre']  ?? null,
        ]);
        json_response(map_photo_urls($rows, 'cover_url', 'photos/albums/'));
    }

    if ($path === '/health') {
        db()->query('SELECT 1');
        json_response(['status' => 'ok']);
    }

    json_error('Not found', 404);
} catch (Throwable $e) {
    json_error('Server error: ' . $e->getMessage(), 500);
}