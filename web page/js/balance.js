//vars voor balance
const showBalance = document.querySelector('#balanceBedrag');
const showIban = document.querySelector('#balanceIban');
const username = document.querySelector('#username');

username.innerHTML = localStorage.getItem('ID');


function showDataBalance() {
	const userIban = localStorage.getItem('ID');
	const userBalance = localStorage.getItem('Balance');


	if (userIban && userBalance) {
		showIban.innerHTML = userIban;
		showBalance.innerHTML = userBalance;
	} else {
		// Handle the case where the data is not available
		console.error("User data not found in localStorage.");
	}
}

showDataBalance();