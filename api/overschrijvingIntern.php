<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: PATCH');
header('Access-Control-Max-Age: 1000');
header('Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With');

define('INDEX', true);

require 'inc/dbcon.php';
require 'inc/base.php';

// Controleer of het een PATCH-verzoek is
if ($_SERVER['REQUEST_METHOD'] === 'PATCH') {
    // Ontvang de JSON-payload van het verzoek
    $json_payload = file_get_contents('php://input');
    $data = json_decode($json_payload);

    if ($data && isset($data->sender_id) && isset($data->receiver_id) && isset($data->amount) && isset($data->date) && isset($data->po_id)) {
        // Haal de ID's en waarde uit de JSON-data
        $sender_id = $data->sender_id;
        $receiver_id = $data->receiver_id;
        $amount = $data->amount;
        $date = $data->date;
        $po_id = $data->po_id;

        // Controleer of de ontvangen gegevens niet leeg zijn
        if (!empty($sender_id) && !empty($receiver_id) && !empty($amount) && !empty($date) && !empty($po_id)) {
            // Maak de ID's veilig voor gebruik in de query om SQL-injectie te voorkomen
            $sender_id = $conn->real_escape_string($sender_id);
            $receiver_id = $conn->real_escape_string($receiver_id);
            $po_id = $conn->real_escape_string($po_id);

            // Begin een transactie om consistentie te waarborgen
            $conn->begin_transaction();

            // Voer de update-query uit om het saldo van de ontvanger bij te werken
            $update_receiver_query = "UPDATE ACCOUNTS SET balance = balance + $amount WHERE id = '$receiver_id'";
            $result_receiver = $conn->query($update_receiver_query);

            // Voer de update-query uit om het saldo van de verzender bij te werken
            $update_sender_query = "UPDATE ACCOUNTS SET balance = balance - $amount WHERE id = '$sender_id'";
            $result_sender = $conn->query($update_sender_query);

            if ($result_receiver && $result_sender) {
                // Commit de transactie als beide queries succesvol zijn uitgevoerd
                $conn->commit();

                // Stuur een succesreactie terug
                $response['code'] = 200;
                $response['status'] = "OK";
                $response['message'] = "Balances successfully updated.";

                // Voeg de transactie toe voor de sender
                $insert_sender_transaction_query = "INSERT INTO `TRANSACTION`(`amount`, `datetime`, `po_id`, `account_id`, `isvalid`, `iscomplete`) VALUES ('-$amount', '$date', '$po_id', '$sender_id', 1, 1)";
                $sender_transaction_result = $conn->query($insert_sender_transaction_query);

                // Voeg de transactie toe voor de receiver
                $insert_receiver_transaction_query = "INSERT INTO `TRANSACTION`(`amount`, `datetime`, `po_id`, `account_id`, `isvalid`, `iscomplete`) VALUES ('$amount', '$date', '$po_id', '$receiver_id', 1, 1)";
                $receiver_transaction_result = $conn->query($insert_receiver_transaction_query);

                if (!($sender_transaction_result && $receiver_transaction_result)) {
                    // Geef een foutmelding terug als een van de transacties niet kon worden toegevoegd
                    $response['code'] = 500;
                    $response['status'] = "Internal Server Error";
                    $response['message'] = "Failed to record transaction.";
                }
            } else {
                // Rollback de transactie als een van de queries is mislukt
                $conn->rollback();

                // Geef een foutmelding terug
                $response['code'] = 500;
                $response['status'] = "Internal Server Error";
                $response['message'] = "Failed to update balances.";
            }
        } else {
            // Ongeldige gegevens ontvangen
            $response['code'] = 400;
            $response['status'] = "Bad Request";
            $response['message'] = "Ontbrekende of lege parameters.";
        }
    } else {
        // Ongeldige gegevens ontvangen
        $response['code'] = 400;
        $response['status'] = "Bad Request";
        $response['message'] = "Ontbrekende of ongeldige JSON-payload.";
    }
} else {
    // Ongeldig verzoek
    $response['code'] = 405;
    $response['status'] = "Method Not Allowed";
    $response['message'] = "Alleen PATCH-verzoeken zijn toegestaan.";
}

// Stuur de JSON-respons terug naar de browser
echo json_encode($response);
?>
