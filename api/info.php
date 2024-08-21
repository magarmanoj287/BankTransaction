<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET'); // gebruik hier het meest toepasselijke HTTP verb. GET zou hier beter zijn ...
header('Access-Control-Max-Age: 1000');
header('Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With');

define ('INDEX', true);
// --- Step 0 : connect to db
require 'inc/dbcon.php';
require 'inc/base.php';

$sql="SELECT * FROM INFO";

$result = $conn -> query($sql);

$data = array();

while ($row = $result->fetch_assoc()) {
    $data[] = $row;
}

$result->free();
$conn->close();
echo json_encode(array("data" => $data, "status" => "ok"));
?>