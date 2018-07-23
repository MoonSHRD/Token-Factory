




## Status
Contracts able to deploy through `new` interface, or through `createToken` function on TokenFactory

Interface(js) creation not working (probably cause of js types), have no time to fix it





**Token Factory**
=====================
This is project for generation new own Tokens.  
  
This project include contracts:  
`ST.sol` - standard token contract template (erc20)
`TokenFactory` - Factory
`Token.sol` - token with ownership (not tested yet)
  
***
Development with truffle
-----------------------------------
1. ```npm install```
2. Install ```ganache ``` from (https://truffleframework.com/ganache) if u want to start local dev ethereum node
3. Start ganache or your ethereum node
4. From project directory open terminal here are commands:
			``` truffle migrate  - deploy contracts described in migrations
			   truffle migrate --reset - deploy contracts, reseting migration counter
			truffle compile - compile contracts
			npm build - create dapp interface build from app.js
			npm run build - create dapp interface, run server on localhost:8080 and watch for changes
			truffle console - dev console attach
			```
5. note that intarface was not updated from Bigfund token manager, so it's not working propriate for now. I think something wrong with types definytion but I have no time to work on it now.

***
## How to interact with contracts

1. ``` truffle console ```
2. ``` migrate --reset ```
3. `ST.new("T","tt",9,10000).then(function(ins){ console.log(ins.address);});`- will deploy new ST token from source ST.sol with parameters T as name, tt as symbol, 9 as decimals and 10000 as initial supply.  Copy address return
4. ` var inst= ST.at('past returned address here'); ` - create instance
5.  `inst.symbol.call();`
6. ` var fac = TokenFactory `
7. `fac.deployed().then(function(instance){return instance.createSToken("N","nn",9,10000);}).then(function(result){return result.logs;});` - function createSToken from Factory
8. `fac.deployed().then(function(instance){return instance.createToken("N","nn",9,10000);}).then(function(result){return result.logs;});` - function createToken from Factory (ownable token)








