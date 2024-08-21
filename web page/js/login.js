// vars voor index
const loginIban = document.querySelector('#iban');
const loginPassword = document.querySelector('#password');
const loginButton = document.querySelector('#buttonInloggen');


// functie voor login
async function login() {
	const myHeaders = new Headers();
	myHeaders.append("Content-Type", "application/json");

	const raw = JSON.stringify({
		"id": loginIban.value,
		"password": loginPassword.value
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
			localStorage.setItem('ID', id)
			localStorage.setItem('Balance', balance)
			localStorage.setItem('Pass', loginPassword.value)
			window.location.href = "account.html";
			showDataOverschrijving();
			showDataBalance();
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


if (window.location.pathname.includes("login.html")) {
	loginButton.addEventListener('click', function () {
		login();
	});
}