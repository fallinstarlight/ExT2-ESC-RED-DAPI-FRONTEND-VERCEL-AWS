<?php
// db.php - minimal PDO connection helper.
declare(strict_types=1);

function db(): PDO
{
    static $pdo = null;
    if ($pdo !== null) {
        return $pdo;
    }

    $envVars = parse_ini_file(__DIR__ . "/.env");

    foreach ($envVars as $key => $value) {
        putenv("$key=$value");
    }

    // Configure these via environment variables on each EC2 instance.
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
    echo json_encode($data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    exit;
}

function json_error(string $message, int $status = 400): void
{
    json_response(['error' => $message], $status);
}

/**
 * Call a stored procedure with named parameters.
 * Returns an array of rows (all result sets if multiple).
 */
function call_proc(string $proc, array $params = []): array
{
    $pdo = db();
    if ($params === []) {
        $sql = "CALL {$proc}()";
        $stmt = $pdo->query($sql);
    } else {
        $placeholders = implode(', ', array_fill(0, count($params), '?'));
        $sql = "CALL {$proc}({$placeholders})";
        $stmt = $pdo->prepare($sql);
        $stmt->execute(array_values($params));
    }
    return $stmt->fetchAll();
}
