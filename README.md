




## Status
Contracts able to deploy through `new` interface, or through `createToken` function on TokenFactory

Crowdsale token (basic implementation) can be created by  `createCrowdsaleToken` - it will deploy
Standard Token with given parameters, then it will deploy standard Crowdsale contract with given parameters
and than it will transfer `totalSupply_` to crowdsale contract.

**subscription** contract able to deploy through `createSubscription` interface on `SubFactory.sol`
it awaits addresses of owner, chat token and crowdsale of this token.
Subscription contract allow to signIn, signOut from a chat/channel using tokens, which have been bought through crowdsale. It's also allow to buy **advertisment** on the channel for tokens and
also have a _ban_ function.

NOTE that now it is only basic functionality for advertisment functions and owner
cannot accept or reject ad proposals yet

Has not been tested properly yet.

Interface(js) creation not working (probably cause of js types), have no time to fix it


## TODO


1. crowdsale token - *done*
2. basic subscruption token - *done*
3. basic advertisment sell functionality - *done*
4. improved advertisment sell functionality - *delayed*


Need to test everything


**Token Factory**
=====================
This is project for generation new own Tokens.  

This project include contracts:  
`ST.sol` - standard token contract template (erc20)
`TokenFactory` - Factory
`Token.sol` - token with ownership
`SubFactory.sol` - factory which deploy new subscription Contracts
`subscription.sol` - subscription contract allow users to signIn or signOut, buying
ads, allow owner to ban user

## Rates, crowdsale prices and how can I live rest of my life about it?


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

## Subscription

Subscritption is a basic contract for subscription managment
`signUp` - procceed a `transferFrom` from a msg.sender, taking 1 token for subscription deposit
think about it as "subscription activision".
`signOut` - return token to a user,stopping subscription.
`banUser` - remove user subscription, token return to a crowdsale contract (I'm not really sure what to do with that)
`setAdPrice` - set price for advertisment in chat, should be set in tokens, in minamal unit format (wei for standard decimals = 18)
`buyAd` - buy advertisment in chat, basic functionality, request payment in tokens, returns event with given ad.message hash

	Messeneger server should recive state updates about subscription through events from this contract.


	`SubFactory` deploy new subscription contracts, receiving addresses of token,chat owner and crowdsale address (for return).



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
## How to interact with contracts on example

1. ``` truffle console ```
2. ``` migrate --reset ```
3. `ST.new("T","tt",9,10000).then(function(ins){ console.log(ins.address);});`- will deploy new ST token from source ST.sol with parameters T as name, tt as symbol, 9 as decimals and 10000 as initial supply.  Copy address return
4. ` var inst= ST.at('past returned address here'); ` - create instance
5.  `inst.symbol.call();`
6. ` var fac = TokenFactory `
7. `fac.deployed().then(function(instance){return instance.createSToken("N","nn",9,10000);}).then(function(result){return result.logs;});` - function createSToken from Factory
8. `fac.deployed().then(function(instance){return instance.createToken("N","nn",9,10000);}).then(function(result){return result.logs;});` - function createToken from Factory (ownable token)
