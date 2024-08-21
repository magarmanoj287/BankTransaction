<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Max-Age: 1000');
header('Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With');

define('INDEX', true);

require 'inc/dbcon.php';
require 'inc/base.php';

// Check if it's a POST request
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Receive the JSON payload from the request
    $json_payload = file_get_contents('php://input');
    $data = json_decode($json_payload);

    // Assuming all values are provided in the body directly, extract them from $data
    $po_id = $data->po_id;
    $po_amount = $data->po_amount;
    $po_message = $data->po_message;
    $po_datetime = $data->po_datetime;
    $ob_id = $data->ob_id;
    $oa_id = $data->oa_id;
    $ob_code = $data->ob_code;
    $ob_datetime = $data->ob_datetime;
    $cb_code = $data->cb_code;
    $cb_datetime = $data->cb_datetime;
    $bb_id = $data->bb_id;
    $ba_id = $data->ba_id;
    $bb_code = $data->bb_code;
    $bb_datetime = $data->bb_datetime;

    // Build the SQL query
    $sql = "INSERT INTO `ACK_IN`(`po_id`, `po_amount`, `po_message`, `po_datetime`, `ob_id`, `oa_id`, `ob_code`, `ob_datetime`, `cb_code`, `cb_datetime`, `bb_id`, `ba_id`, `bb_code`, `bb_datetime`) VALUES ('$po_id','$po_amount','$po_message','$po_datetime','$ob_id','$oa_id','$ob_code','$ob_datetime','$cb_code','$cb_datetime','$bb_id','$ba_id','$bb_code','$bb_datetime')";

    // Execute the query
    if ($conn->query($sql) === TRUE) {
        $response['code'] = 200;
        $response['status'] = "OK";
        $response['data'] = "Record inserted successfully";
    } else {
        $response['code'] = 500;
        $response['status'] = "Internal Server Error";
        $response['data'] = "Error: " . $sql . "<br>" . $conn->error;
    }
} else {
    // Invalid request
    $response['code'] = 405;
    $response['status'] = "Method Not Allowed";
    $response['data'] = "Only POST requests are allowed.";
}

// Send the JSON response back to the browser
echo json_encode($response);
?>
