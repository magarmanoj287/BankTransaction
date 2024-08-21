<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET'); // Allowing both GET and POST methods
header('Content-Type: application/json');
header('Access-Control-Max-Age: 1000');
header('Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With');

define('INDEX', true);

require 'inc/dbcon.php'; 
require 'inc/base.php'; 

$sqlSelect = "SELECT * FROM PO_NEW";
$result = $conn->query($sqlSelect);

if (!$result) {
    die('{"error":"Query failed","errNo":"' . json_encode($conn->errno) .'","mysqlError":"' . json_encode($conn->error) .'","status":"fail"}');
}

$sqlInsert = "INSERT INTO PO_OUT (po_id, po_amount, po_message, po_datetime, ob_id, oa_id, ob_code, ob_datetime, cb_code, cb_datetime, bb_id, ba_id, bb_code, bb_datetime) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
$stmt = $conn->prepare($sqlInsert);

if (!$stmt) {
    die('{"error":"Prepared Statement failed on prepare","errNo":"' . json_encode($conn->errno) .'","mysqlError":"' . json_encode($conn->error) .'","status":"fail"}');
}

$dataList = array();

$inserted_count = 0; 

while ($row = $result->fetch_assoc()) {
    $stmt->bind_param("sdssssssssssss", 
        $row['po_id'], 
        $row['po_amount'], 
        $row['po_message'], 
        $row['po_datetime'], 
        $row['ob_id'], 
        $row['oa_id'], 
        $row['ob_code'], 
        $row['ob_datetime'], 
        $row['cb_code'], 
        $row['cb_datetime'], 
        $row['bb_id'], 
        $row['ba_id'], 
        $row['bb_code'], 
        $row['bb_datetime']
    );
    if ($stmt->execute()) {
        $inserted_count += $stmt->affected_rows;

        $deleteSql = "DELETE FROM PO_NEW WHERE po_id = ?";
        $deleteStmt = $conn->prepare($deleteSql);
        $deleteStmt->bind_param("s", $row['po_id']);
        if (!$deleteStmt->execute()) {
            die('{"error":"Delete failed","errNo":"' . json_encode($deleteStmt->errno) .'","mysqlError":"' . json_encode($deleteStmt->error) .'","status":"fail"}');
        }
    }
    $deleteStmt->close();

    $endpoint = "https://stevenop.be/pingfin/api/po_in/";

    $curl = curl_init();
    
    $postData = json_encode(array("data" => array($row)));

    // Set curl options
    curl_setopt_array($curl, array(
        CURLOPT_URL => $endpoint,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => $postData, 
        CURLOPT_SSL_VERIFYPEER => false, 
        CURLOPT_HTTPHEADER => array(
            'Content-Type: application/json',
            'Authorization: Bearer TELtBGGwD5N1Ui1PPIYqQojcCIYCn3Qx' 
        )
    ));

    // Execute curl request
    $response = curl_exec($curl);

    // Check for errors
    if (curl_errno($curl)) {
        $error_msg = curl_error($curl);
        // Handle error
        echo '{"error":"Communication with Clear Banking API failed","message":"' . $error_msg . '","status":"fail"}';
    } else {
        // Decode the response
        $decoded_response = json_decode($response, true);

        // Check if the response is successful
        if(isset($decoded_response['status']) && $decoded_response['status'] === 200) {
            // Add current row data to dataList array
            $dataList[] = array(
                "po_id" => $row['po_id'],
                "po_amount" => $row['po_amount'],
                "po_message" => $row['po_message'],
                "po_datetime" => $row['po_datetime'],
                "ob_id" => $row['ob_id'],
                "oa_id" => $row['oa_id'],
                "ob_code" => $row['ob_code'],
                "ob_datetime" => $row['ob_datetime'],
                "bb_id" => $row['bb_id'],
                "ba_id" => $row['ba_id']
            );
        } else {
            // Handle error response from Clear Banking API
            $errorMessage = isset($decoded_response['message']) ? $decoded_response['message'] : 'Unknown error';
            echo '{"error":"Clear Banking API returned error response","message":"' . $errorMessage . '","status":"fail"}';
        }
    }

    // Close curl session
    curl_close($curl);
}

$conn->commit();

$stmt->close();
$result->free();

$conn->close();

$response = array(
    "status" => 200,
    "data" => $dataList,
    "ok" => true
);

echo json_encode(array("status" => 200, "data" => "Result: $inserted_count Payment Orders Processed.", "ok" => true));
?>