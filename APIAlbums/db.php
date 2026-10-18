<?php
declare(strict_types=1);

function db(): PDO
{
    static $pdo = null;
    if ($pdo !== null) return $pdo;

    $envVars = parse_ini_file(__DIR__ . "/.env");
    foreach ($envVars as $key => $value) putenv("$key=$value");

    $host = getenv('SERVER') ?: '127.0.0.1';
    $port = getenv('PORT') ?: '3306';
    $name = getenv('SCHEMA') ?: 'music_catalog';
    $user = getenv('USER') ?: 'music_app';
    $pass = getenv('PASSWORD') ?: '';

    $dsn = "mysql:host={$host};port={$port};dbname={$name};charset=utf8mb4";
    $pdo = new PDO($dsn, $user, $pass, [
        PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES   => false,
    ]);
    return $pdo;
}

function json_response($data, int $status = 200): void
{
    http_response_code($status);
    header('Content-Type: application/json; charset=utf-8');
    header('Access-Control-Allow-Origin: *');
    echo json_encode($data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    exit;
}

function json_error(string $message, int $status = 400): void
{
    json_response(['error' => $message], $status);
}

/**
 * Build the public base URL of this API (scheme + host + optional port).
 * Used to turn stored relative photo paths into absolute URLs.
 */
function public_base_url(): string
{
    $scheme = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https' : 'http';
    $host   = $_SERVER['HTTP_HOST'] ?? 'localhost';
    return "{$scheme}://{$host}";
}

/**
 * Normalize a stored photo path to an absolute URL.
 * - If it's already absolute (http/https), return as-is.
 * - Otherwise, prepend the given subfolder (e.g. "photos/artists/")
 *   and the API's base URL.
 *
 * $folder MUST include a trailing slash.
 */
function photo_url(?string $stored, string $folder): ?string
{
    if ($stored === null || $stored === '') return null;
    if (preg_match('#^https?://#i', $stored)) return $stored;

    $scheme = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https' : 'http';
    $host   = $_SERVER['HTTP_HOST'] ?? 'localhost';
    $base   = "{$scheme}://{$host}";

    // Strip any leading slash and any existing "photos/<kind>/" prefix so we
    // never end up with photos/artists/photos/artists/foo.jpg.
    $stored = ltrim($stored, '/');
    if (str_starts_with($stored, $folder)) {
        $stored = substr($stored, strlen($folder));
    }
    // Also strip a bare "photos/" prefix if the DB stores just that.
    if (str_starts_with($stored, 'photos/')) {
        $stored = substr($stored, strlen('photos/'));
    }

    return rtrim($base, '/') . '/' . $folder . ltrim($stored, '/');
}

/** Map every row's a given column through photo_url(). */
function map_photo_urls(array $rows, string $column, string $folder): array
{
    foreach ($rows as &$r) {
        if (array_key_exists($column, $r)) {
            $r[$column] = photo_url($r[$column], $folder);
        }
    }
    return $rows;
}

function call_proc(string $proc, array $params = []): array
{
    $pdo = db();
    if ($params === []) {
        $stmt = $pdo->query("CALL {$proc}()");
    } else {
        $ph   = implode(', ', array_fill(0, count($params), '?'));
        $stmt = $pdo->prepare("CALL {$proc}({$ph})");
        $stmt->execute(array_values($params));
    }
    // With PDO + MySQL stored procedures you often need to close the cursor
    // before another query can run; fetchAll() handles that here.
    return $stmt->fetchAll();
}