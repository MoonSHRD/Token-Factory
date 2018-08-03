




## Status
Contracts able to deploy through `new` interface, or through `createToken` function on TokenFactory

Crowdsale token (basic implementation) can be created by  `createCrowdsaleToken` - it will deploy
Standard Token with given parameters, then it will deploy standard Crowdsale contract with given parameters
and than it will transfer `totalSupply_` to crowdsale contract.

Has not been tested properly yet.

Interface(js) creation not working (probably cause of js types), have no time to fix it


## TODO


1. crowdsale token - *done*
2. basic subscruption token
3. advanced subscription token
4. ERC223 (separate branch)


**Token Factory**
=====================
This is project for generation new own Tokens.  

This project include contracts:  
`ST.sol` - standard token contract template (erc20)
`TokenFactory` - Factory
`Token.sol` - token with ownership

## Rates, crowdsale prices and how can I live rest of my life about it?

` function createCrowdsaleToken(string _name,
 string _symbol, uint8 _decimals,
 uint _INITIAL_SUPPLY, uint256 _rate, address _wallet) public returns(Token,address){
	 Token tok = createToken(_name,_symbol,_decimals,_INITIAL_SUPPLY);
//   Token tok = Token(new Token(_name, _symbol, _INITIAL_SUPPLY, msg.sender));
	 address crd = createCrowdsale(_rate,_wallet,tok);
	 tok.prepareCrowdsale(crd);
	 return (tok,crd);


}`

	As you can see, function awaits parameters 'decimals' and 'rate' to understand the price
	of token user want to set up.

	The lowest undividable unit in token should be setup by the 'decimals' parameter.
	For example, if we want lowest unit as 0,001, then we should set up the decimals in value 3.

	Ethereum itself has the lowest unit called `Wei` and has decimals value 18, so if
	we suggest that 1 moonshard is 1$, and we creating new token with decimals 18 and rate =1, then
	price for 1 NewToken = 1$.

	If we will move decimals forward or backward we can get 1 NewToken = 10$ when decimals = 19 and
	1 NewToken = 0,1$ when decimals = 17, therefore we can change price of token moving floating point like that.

	Other parameter for price is _rate_ . This mean conversion rate, or how many tokens buyer getting per
	one payable unit.

	For example when d=18 and r=1 buyer get 1 token per 1$. If rate is 2, than 2 token per 1$. In second case price of the token will be 0,5$ and so on


	Probably we should to implement some mechanism of dynamic price calculation on client side. (for autocalculation decimals and rate for given user price)



***
Development with truffle
-----------------------------------
1. ```npm install```
2. Install ```ganache ``` from (https://truffleframework.com/ganache) if u want to start local dev ethereum node
3. Start ganache or your ethereum node
4. From project directory open terminal here are commands:
			`truffle migrate --reset`

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
