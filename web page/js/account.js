// Manoj code
const btnAccount = document.querySelector('#accountBtn');
const btnBankInfo = document.querySelector('#bankBtn');
const username = document.querySelector('#username');

let baseApiAddress = "https://manojmagar.be/internationalWeek/";
let bankInfoDisplayed = false;
let bankInfoData;
let accountData;

username.innerHTML = localStorage.getItem('ID');

function getBankInfo() {
	let url = baseApiAddress + "info.php";

	fetch(url)
		.then(function (response) {
			return response.json();
		})
		.then(function (responseData) {
			var info = responseData.data;
			if (info.length > 0) {
				bankInfoData = info[0];
				toggleBankInfo();
			}
		})
		.catch(function (error) {
			alert("fout : " + error);
		});
}

function toggleBankInfo() {
	let bankInfoSection = document.getElementById("bankInfoSection");
	if (bankInfoDisplayed) {
		bankInfoSection.style.display = "none";
		bankInfoDisplayed = false;
	} else {
		if (bankInfoData) {
			displayBankInfo(bankInfoData);
			bankInfoDisplayed = true;
		} else {
			getBankInfo();
		}
	}
}

function displayBankInfo(info) {
	document.getElementById("bankInfoSection").style.display = "block";
	let table = document.getElementById("bankInfoBody");
	if (table.rows.length > 0) {
		console.log("Bank info is already displayed.");
		return;
	}
	let newRow = table.insertRow();
	let idCell = newRow.insertCell(0);
	let nameCell = newRow.insertCell(1);
	let descriptionCell = newRow.insertCell(2);

	idCell.innerText = info.id;
	nameCell.innerText = info.name;
	descriptionCell.innerText = info.description;
}



if (window.location.pathname.includes("account.html")) {
	btnBankInfo.addEventListener("click", function () {
		toggleBankInfo();
	});
}