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

    if ($data && isset($data->id) && isset($data->amount) && isset($data->date) && isset($data->po_id)) {
        // Haal de ID, bedrag, datum en po_id uit de JSON-data
        $id = $data->id;
        $amount = $data->amount;
        $date = $data->date;
        $po_id = $data->po_id;

        // Controleer of de ontvangen gegevens niet leeg zijn
        if (!empty($id) && !empty($amount) && !empty($date) && !empty($po_id)) {
            // Maak de ID veilig voor gebruik in de query om SQL-injectie te voorkomen
            $id = $conn->real_escape_string($id);

            // Voer de update-query uit om het saldo van de rekening bij te werken
            $update_query = "UPDATE ACCOUNTS SET balance = balance - $amount WHERE id = '$id'";
            $result = $conn->query($update_query);

            if ($result) {
                // Voeg de transactie toe
                $insert_transaction_query = "INSERT INTO `TRANSACTION`(`amount`, `datetime`, `po_id`, `account_id`, `isvalid`, `iscomplete`) VALUES ('-$amount', '$date', '$po_id', '$id', 1, 1)";
                $transaction_result = $conn->query($insert_transaction_query);

                if ($transaction_result) {
                    // Stuur een succesreactie terug
                    $response['code'] = 200;
                    $response['status'] = "OK";
                    $response['message'] = "Balance successfully updated. Transaction recorded.";
                } else {
                    // Geef een foutmelding terug als de transactie niet kon worden toegevoegd
                    $response['code'] = 500;
                    $response['status'] = "Internal Server Error";
                    $response['message'] = "Failed to record transaction.";
                }
            } else {
                // Geef een foutmelding terug als de saldo-update niet is gelukt
                $response['code'] = 500;
                $response['status'] = "Internal Server Error";
                $response['message'] = "Failed to update balance.";
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
