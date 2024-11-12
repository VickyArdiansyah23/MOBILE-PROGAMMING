<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

// Menangani preflight request (OPTIONS)
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit();
}

// Koneksi ke database MySQL
$koneksi = new mysqli("localhost", "root", "", "db_flutter");
if ($koneksi->connect_error) {
    die("Connection failed: " . $koneksi->connect_error);
}

// Ambil data dari permintaan POST (dari Flutter misalnya)
if (isset($_POST['username']) && isset($_POST['password'])) {
    $username = $_POST['username'];
    $password = $_POST['password'];

    // Lindungi dari SQL Injection
    $username = mysqli_real_escape_string($koneksi, $username);
    $password = mysqli_real_escape_string($koneksi, $password);

    // Query untuk mencari user berdasarkan username dan password
    $query = "SELECT * FROM users WHERE username='$username' AND password='$password'";
    $result = mysqli_query($koneksi, $query);

    if (mysqli_num_rows($result) == 1) {
        // User ditemukan, proses login sukses
        $user = mysqli_fetch_assoc($result);
        echo json_encode(array('status' => 'success', 'user' => $user));
    } else {
        // User tidak ditemukan, proses login gagal
        echo json_encode(array('status' => 'error', 'message' => 'Login failed. Invalid credentials.'));
    }
} else {
    echo json_encode(array('status' => 'error', 'message' => 'Username or password not provided.'));
}

// Tutup koneksi database
mysqli_close($koneksi);
?>