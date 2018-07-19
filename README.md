**Token Factory**
=====================
This is project for generation new own Tokens.  
  
This project include contracts:  
[Token](https://github.com/KenjuDari/Token-Factory/blob/master/contracts/Token.sol) - which is template of standard token.  
[TokenFactory](https://github.com/KenjuDari/Token-Factory/blob/master/contracts/TokenFactory.sol) - which allow to create your own token automaticaly.  
***
Setting Up Token Factory  
-----------------------------------
Make sure you have NPM Git installed  
Clone the repo by using git clone (insert repo here)  
Open a terminal, navigate to the project folder, and install OpenZeppelin  
	npm init -y  
	npm install -E openzeppelin-solidity  
Install and start the Ganache from https://truffleframework.com/ganache  
Install the Truffle CLI by running  
	npm install -g truffle  
Compile the smart contract by running  
	truffle compile  
Deploy the smart contract by running  
	truffle migrate  
Install Metamask browser extension  
Start the local web server by running  
	npm run dev  
  