<?php
// Set CORS headers
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Origin, Content-Type, Accept, Authorization, X-Requested-With');

// Database connection (replace with your own details)
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "db_flutter";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die(json_encode(['error' => 'Connection failed: ' . $conn->connect_error]));
}

// Query to fetch data from the checkout table
$sql = "SELECT * FROM checkout";
$result = $conn->query($sql);

// Prepare the response array
$checkouts = [];

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        // Convert binary data to base64
        if (!empty($row['image'])) {
            $row['image'] = base64_encode($row['image']);
        }
        $checkouts[] = $row;
    }
} else {
    $checkouts = ['message' => 'No records found'];
}

// Output the data as JSON
header('Content-Type: application/json');
echo json_encode($checkouts);

// Close connection
$conn->close();
?>
