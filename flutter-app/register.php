<?php
header("Access-Control-Allow-Origin: *"); // Allow requests from any origin
header("Access-Control-Allow-Methods: POST"); // Allow only POST requests
header("Access-Control-Allow-Headers: Content-Type"); // Allow the Content-Type header

// Inisialisasi koneksi ke database
$koneksi = new mysqli("localhost", "root", "", "db_flutter");

// Periksa koneksi
if ($koneksi->connect_error) {
    die("Connection failed: " . $koneksi->connect_error);
}

// Ambil data dari request POST
$username = $_POST['username'];
$password = $_POST['password'];
$nama = $_POST['nama']; // Ambil data nama pengguna

// Query SQL untuk menyimpan data
$query = "INSERT INTO users (username, password, nama) VALUES ('$username', '$password', '$nama')";

// Jalankan query
if ($koneksi->query($query) === TRUE) {
    // Jika sukses menyimpan, kirim respons ke Flutter app
    $response = array('success' => true, 'message' => 'User registered successfully');
    echo json_encode($response);
} else {
    // Jika gagal menyimpan, kirim respons error ke Flutter app
    $response = array('success' => false, 'message' => 'Error registering user: ' . $koneksi->error);
    echo json_encode($response);
}

// Tutup koneksi database
$koneksi->close();
?>
