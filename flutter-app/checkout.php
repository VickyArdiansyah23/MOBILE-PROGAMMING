<?php
header("Access-Control-Allow-Origin: *"); // Allow requests from any origin
header("Access-Control-Allow-Methods: POST"); // Allow only POST requests
header("Access-Control-Allow-Headers: Content-Type"); // Allow the Content-Type header
header('Content-Type: application/json');

// Initialize the database connection
$koneksi = new mysqli("localhost", "root", "", "db_flutter");

// Check the connection
if ($koneksi->connect_error) {
    die(json_encode(["status" => "error", "message" => "Connection failed: " . $koneksi->connect_error]));
}

// Handle POST request
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $name = $_POST['name'];
    $address = $_POST['address'];
    $phone = $_POST['phone'];
    $productPrice = str_replace(',', '', $_POST['productPrice']); // Remove commas from the price

    // Insert form data into the database
    $sql = "INSERT INTO checkout (name, address, phone, productPrice) VALUES (?, ?, ?, ?)";
    $stmt = $koneksi->prepare($sql);
    $stmt->bind_param("ssss", $name, $address, $phone, $productPrice);

    if ($stmt->execute()) {
        echo json_encode(["status" => "success", "message" => "Checkout data saved successfully"]);
    } else {
        echo json_encode(["status" => "error", "message" => "Error: " . $stmt->error]);
    }

    // Close the statement
    $stmt->close();
} else {
    echo json_encode(["status" => "error", "message" => "Invalid request"]);
}

// Close the connection
$koneksi->close();
?>
