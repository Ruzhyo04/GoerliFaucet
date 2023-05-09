let web3;
let accounts;
let vaultContract;
let faucetContract;

window.onload = async function() {
    if (window.ethereum) {
        web3 = new Web3(window.ethereum);
        try {
            accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
            initContracts();
        } catch (error) {
            console.error("User denied account access");
        }
    } else {
        console.log('Non-Ethereum browser detected. You should consider trying MetaMask!');
    }

    document.getElementById('connect').onclick = connect;
    document.getElementById('deposit').onclick = deposit;
    document.getElementById('claim').onclick = claim;
}

function initContracts() {
    const vaultAbi = []; // Fill in with the ABI of your vault contract
    const faucetAbi = []; // Fill in with the ABI of your faucet contract

    const vaultAddress = ''; // Fill in with the address of your deployed vault contract
    const faucetAddress = ''; // Fill in with the address of your deployed faucet contract

    vaultContract = new web3.eth.Contract(vaultAbi, vaultAddress);
    faucetContract = new web3.eth.Contract(faucetAbi, faucetAddress);
}

async function connect() {
    accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
}

async function deposit() {
    const tokenId = document.getElementById('depositTokenId').value;
    await vaultContract.methods.deposit(tokenId).send({ from: accounts[0] });
}

async function claim() {
    await faucetContract.methods.distributeFaucet().send({ from: accounts[0] });
}
