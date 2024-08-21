<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Max-Age: 1000');
header('Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With');

define('INDEX', true);

require 'inc/dbcon.php';
require 'inc/base.php';

// Controleer of het een POST-verzoek is
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Ontvang de JSON-payload van het verzoek
    $json_payload = file_get_contents('php://input');
    $data = json_decode($json_payload);

    if ($data && isset($data->id) && isset($data->password)) {
        // Haal de ID en wachtwoord uit de JSON-data
        $id = $data->id;
        $password = $data->password;

        // Maak de ID veilig voor gebruik in de query om SQL-injectie te voorkomen
        $id = $conn->real_escape_string($id);

        // Voer een SQL-query uit om de accountgegevens op te halen op basis van de opgegeven ID
        $sql = "SELECT * FROM ACCOUNTS WHERE id = '$id'";

        // Voer de query uit
        $result = $conn->query($sql);

        if ($result && $result->num_rows > 0) {
            // Account gevonden, haal de gegevens op
            $row = $result->fetch_assoc();
            // Controleer of IBAN aanwezig is
            if (!empty($row['id'])) {
                // Vergelijk het opgehaalde wachtwoord met het verstrekte wachtwoord
                if ($password === $row['password']) {
                    // Wachtwoorden komen overeen, stuur alle gegevens terug
                    $response['code'] = 200;
                    $response['status'] = "OK";
                    $response['data'] = array("id" => $row['id'], "balance" => $row['balance']);
                } else {
                    // Wachtwoorden komen niet overeen
                    $response['code'] = 401;
                    $response['status'] = "Unauthorized";
                    $response['data'] = "Onjuist wachtwoord";
                }
            } else {
                // Geen IBAN gevonden voor de opgegeven ID
                $response['code'] = 404;
                $response['status'] = "Not Found";
                $response['data'] = "Geen IBAN gevonden voor de opgegeven ID";
            }
        } else {
            // Geen account gevonden voor de opgegeven ID
            $response['code'] = 404;
            $response['status'] = "Not Found";
            $response['data'] = "Geen account gevonden voor de opgegeven ID";
        }
    } else {
        // Ongeldige gegevens ontvangen
        $response['code'] = 400;
        $response['status'] = "Bad Request";
        $response['data'] = "Ongeldige ID of wachtwoord ontvangen";
    }
} else {
    // Ongeldig verzoek
    $response['code'] = 405;
    $response['status'] = "Method Not Allowed";
    $response['data'] = "Alleen POST-verzoeken zijn toegestaan.";
}

// Stuur de JSON-respons terug naar de browser
echo json_encode($response);
?>
