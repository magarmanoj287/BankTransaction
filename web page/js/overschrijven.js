// get current time
function getCurrentDateTime() {
	const now = new Date();
	const year = now.getFullYear();
	const month = String(now.getMonth() + 1).padStart(2, '0');
	const day = String(now.getDate()).padStart(2, '0');
	const hours = String(now.getHours()).padStart(2, '0');
	const minutes = String(now.getMinutes()).padStart(2, '0');
	const seconds = String(now.getSeconds()).padStart(2, '0');

	return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
}

const currentDateTime = getCurrentDateTime();
console.log(currentDateTime);

// vars voor overschrijven
const verzenderIban = document.querySelector('#verzenderIban');
const ontvangerNaam = document.querySelector('#ontvangerNaam');
const ontvangerIban = document.querySelector('#ontvangerIban');
const bedrag = document.querySelector('#bedrag');
const overschrijfVersturen = document.querySelector('#versturen');
const mededeling = document.querySelector('#mededeling');
const username = document.querySelector('#username');

username.innerHTML = localStorage.getItem('ID');


// functie voor overschrijven

async function overschrijven() {
	try {
		const internalIBANList = await pullID(); // Fetch all IDs

		// Check if sender's IBAN is internal or external
		const isInternalSender = isInternalIBAN(verzenderIban.innerHTML, internalIBANList);

		if (isInternalSender) {
			await overschrijvenIntern(); // Internal transaction
		} else {
			await overschrijvenExtern(); // External transaction
		}
	} catch (error) {
		console.error("Error:", error);
		// Handle errors
	}
}
async function overschrijvenIntern() {
	try {
		getCurrentDateTime();
		const myHeaders = new Headers();
		myHeaders.append("Content-Type", "application/json");

		console.log(verzenderIban.innerHTML)
		console.log(ontvangerIban.value)
		console.log(bedrag.value)
		console.log(currentDateTime)

		const raw = JSON.stringify({
			"sender_id": verzenderIban.innerHTML,
			"receiver_id": ontvangerIban.value,
			"amount": bedrag.value,
			"date": currentDateTime,
			"po_id": "FUTOBE37_LoTRfYoN"
		});

		const requestOptions = {
			method: "PATCH", // Change method to PATCH as required by the API
			headers: myHeaders,
			body: raw,
			redirect: "follow"
		};

		const response = await fetch("https://manojmagar.be/internationalWeek/overschrijvingIntern.php", requestOptions);
		const responseData = await response.json(); // Parse JSON response
		console.log(responseData); // Log the response for debugging

		if (responseData.code === 200 && responseData.status === "OK") {
			console.log("Transaction successful");
			// Handle successful transaction
			balanceUpdate();
			ontvangerNaam.value = '';
			ontvangerIban.value = '';
			bedrag.value = '';
			mededeling.value = '';
		} else {
			console.error("Transaction failed:", responseData.message);
			// Handle failed transaction, display error message, etc.
		}
	} catch (error) {
		console.error("Error:", error);
		// Handle network errors, exceptions, etc.
	}
}

async function overschrijvenExtern() {
	try {
		getCurrentDateTime();
		const myHeaders = new Headers();
		myHeaders.append("Content-Type", "application/json");

		console.log(verzenderIban.innerHTML);
		console.log(ontvangerIban.value);
		console.log(bedrag.value);
		console.log(currentDateTime);

		const raw = JSON.stringify({
			"po_amount": bedrag.value,
			"po_datetime": currentDateTime,
			"ob_id": "AXABBE22",
			"oa_id": "BE11063123456789",
			"bb_id": "OONXBEBB",
			"ba_id": "BE42456456789012",
		});

		const requestOptions = {
			method: "PATCH",
			headers: myHeaders,
			body: raw,
			redirect: "follow"
		};

		const response = await fetch("https://manojmagar.be/internationalWeek/overschrijvingExternUitgaand.php", requestOptions);
		const responseData = await response.json();
		console.log(responseData);

		if (responseData.code === 200 && responseData.status === "OK") {
			console.log("Transaction successful");

		} else {
			console.error("Transaction failed:", responseData.message);
		}
	} catch (error) {
		console.error("Error:", error);
	}
}



overschrijfVersturen.addEventListener('click', overschrijven)

async function balanceUpdate() {
	const myHeaders = new Headers();
	myHeaders.append("Content-Type", "application/json");

	const raw = JSON.stringify({
		"id": localStorage.getItem('ID'),
		"password": localStorage.getItem('Pass')
	});

	const requestOptions = {
		method: "POST",
		headers: myHeaders,
		body: raw,
		redirect: "follow"
	};

	try {
		const response = await fetch("https://manojmagar.be/internationalWeek/login.php", requestOptions);
		const responseData = await response.json(); // Parse JSON response
		if (responseData.code === 200 && responseData.status === "OK") {
			const { id, balance } = responseData.data; // Extract id and balance from data object
			console.log("ID:", id);
			console.log("Balance:", balance);
			// Now you can use the id and balance variables as needed
			// For example, you can store them in variables or update UI elements
			localStorage.setItem('Balance', balance)
		}
		else {
			console.error("Login failed:", responseData.status);
			// Handle failed login, display error message, etc.
		}
	} catch (error) {
		console.error("Error:", error);
		// Handle network errors, exceptions, etc.
	}
}

function isInternalIBAN(iban, internalIBANList) {
	// Check if the given IBAN is internal or external
	return internalIBANList.includes(iban);
}

async function pullID() {
	try {
		const raw = "";

		const requestOptions = {
			method: "POST",
			body: raw,
			redirect: "follow"
		};

		const response = await fetch("https://manojmagar.be/internationalWeek/test.php", requestOptions);
		const responseData = await response.json(); // Parse JSON response

		console.log("Response Data:", responseData); // Log the response data

		if (responseData.status === 'ok') {
			return responseData.data.map(entry => entry.id); // Assuming the response is an object with a 'data' property containing an array of objects with an 'id' property
		} else {
			console.error("Invalid response format:", responseData);
			return []; // Return an empty array or handle the error accordingly
		}
	} catch (error) {
		console.error("Error:", error);
		return []; // Return an empty array or handle the error accordingly
	}
}

function showDataOverschrijving() {
	iban = localStorage.getItem('ID');

	if (iban) {
		verzenderIban.innerHTML = iban;
	} else {
		// Handle the case where the data is not available
		console.error("Data not found in localStorage.");
	}
}

showDataOverschrijving();