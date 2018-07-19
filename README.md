**Token Factory**
=====================
This is project for generation new own Tokens.  
  
This project include contracts:  
[Token](https://github.com/KenjuDari/Token-Factory/blob/master/contracts/Token.sol) - which is template of standard token.  
[TokenFactory](https://github.com/KenjuDari/Token-Factory/blob/master/contracts/TokenFactory.sol) - which allow to create your own token automaticaly.  
***
Setting Up Token Factory  
-----------------------------------
1. Make sure you have NPM Git installed  
2. Clone the repo by using git clone (insert repo here)  
3. Open a terminal, navigate to the project folder, and install OpenZeppelin  
***
		npm init -y  
***
		npm install -E openzeppelin-solidity  
4. Install and start the Ganache from https://truffleframework.com/ganache  
5. Install the Truffle CLI by running  
***
		npm install -g truffle  
***
6. Compile the smart contract by running  
***
		truffle compile  
7. Deploy the smart contract by running  
***
		truffle migrate  
8. Install Metamask browser extension  
9. Start the local web server by running  
***
		npm run dev  
  