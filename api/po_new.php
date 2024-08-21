<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Max-Age: 1000');
header('Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With');

define('INDEX', true);

require 'inc/dbcon.php';
require 'inc/base.php';

$json_data = file_get_contents('php://input');
$data = json_decode($json_data, true);

$inserted_count = 0; 

foreach ($data['data'] as $item) {
    $po_id = $item['po_id'] ?? uniqid('FUTOBE37', true);
    $po_amount = $item['po_amount'] ?? 0; 
    $po_message = $item['po_message'] ?? '';
    $po_datetime = $item['po_datetime'] ?? date('Y-m-d H:i:s');
    $ob_id = $item['ob_id'] ?? '';
    $oa_id = $item['oa_id'] ?? '';
    $ob_code = $item['ob_code'] ?? '';
    $ob_datetime = $item['ob_datetime'] ?? date('Y-m-d H:i:s'); 
    $cb_code = $item['cb_code'] ?? '';
    $cb_datetime = $item['cb_datetime'] ?? date('Y-m-d H:i:s'); 
    $bb_id = $item['bb_id'] ?? '';
    $ba_id = $item['ba_id'] ?? '';
    $bb_code = $item['bb_code'] ?? '';
    $bb_datetime = $item['bb_datetime'] ?? date('Y-m-d H:i:s');

    $sqlInsert = "INSERT INTO PO_NEW (po_id, po_amount, po_message, po_datetime, ob_id, oa_id, ob_code, ob_datetime, cb_code, cb_datetime, bb_id, ba_id, bb_code, bb_datetime) 
                  VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    $stmt = $conn->prepare($sqlInsert);

    if (!$stmt) {
        die('{"error":"Prepared Statement failed on prepare","errNo":"' . json_encode($conn->errno) .'","mysqlError":"' . json_encode($conn->error) .'","status":"fail"}');
    }

    $stmt->bind_param("sdssssssssssss", $po_id, $po_amount, $po_message, $po_datetime, $ob_id, $oa_id, $ob_code, $ob_datetime, $cb_code, $cb_datetime, $bb_id, $ba_id, $bb_code, $bb_datetime);

    if (!$stmt->execute()) {
        die('{"error":"Prepared Statement failed on execute","errNo":"' . json_encode($stmt->errno) .'","mysqlError":"' . json_encode($stmt->error) .'","status":"fail"}');
    }

    $inserted_count += $stmt->affected_rows; 

    $stmt->close();
}

$conn->close();

echo json_encode(array("status" => 200, "data" => "Result: $inserted_count Payment Orders Processed.", "ok" => true));
?>