Goerli Faucet 
Welcome to the repository for our perpetually funded faucet project. This consists of a vault contract for holding UniV3 positions and an autonomous contract for harvesting LP rewards. These contracts are developed using Solidity and can be deployed on the Ethereum blockchain. It is hoped they will contribute to the public good of the ecosystem.

Version: 0.01 - Written by ChatGPT 4.0. It is meant to serve as a prototype and starting point, in the hope that someone with a keen eye for smart contracts will fork or submit pull requests.

Vault Contract (GoerliFaucetVault.sol):
This contract is designed to hold UniV3 positions. Any user can deposit a UniV3 style liquidity pool NFT containing a balance into the vault, 
Autonomous Faucet Contract (GoerliFaucet.sol):
This contract is designed to harvest LP rewards semi-regularly, convert them to ETH, and make that ETH available in a faucet. This process is completely autonomous and contributes to the continuous provision of testnet resources.
Frontend (FaucetFrontend.html)
A basic interface to be hosted on IPFS that users can interact with to receive faucet funds and facilitate donations.

The admin keys for both contracts will be burned to ensure full decentralization and to avoid any possible manipulation.This means that liquidity deposited into the vault should be created with broad ranges or in a UniV2 style infinite range and with low fees in order to ensure that their time accumulating for the faucet is maximized. 

Getting Started
To deploy and interact with these contracts, you need to have the following prerequisites:

Node.js and npm installed on your system.
Truffle installed globally (npm install -g truffle)
Ganache installed for a local blockchain development environment.
Steps
Clone this repository: git clone https://github.com/username/ethereum-smart-contract.git
Install all dependencies by running: npm install
Start Ganache and create a workspace that points to truffle-config.js in this project.
Compile the contracts: truffle compile
Migrate the contracts to your local blockchain: truffle migrate
Test the contracts: truffle test
Deployment
To deploy the contracts on a test network or the main Ethereum network, you need to have an Ethereum Wallet installed and set up.

Please update truffle-config.js with the respective network details before running truffle migrate --network <network_name>.

Usage
Once deployed, anyone can deposit their UniV3 style NFTs into the vault contract, and the autonomous faucet contract will regularly convert the LP rewards into ETH, making it available through the faucet (FaucetFrontend.html). Users will be able to interact with the front end to receive faucet funds and easily make donations.

Contributing
Contributions are essential! Feel free to open issues or submit pull requests.

License
This project is licensed under TheUnlicense
