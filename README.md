
#Token Factory
=====================

MoonShard - is a blog platform, which use model __token-as-a-subscription__


Therefore each channel or chat inside MoonShard have it's own token.

This means, for example, that each time someone subscribe on __closed__ blog -
he **buy** the token of the channel. Then, these tokens can be gifted to someone else like literally paid subscriptions to specifiec channel

Otherwise, if author want to keep his original content free to anyone, he can **accept** money for sponsorship and make a protected deals for  negotiation of **sponsorship** content.

These tokens also can be a 'share' what give ordinary subscriber get a share from given sponsorhip payment as sponsor prize.

Tokens can be also distributed among subscribers for a high activity in the channel/chat, what give author opportunity to distribute it's own token.

Community can exchange tokens for some reward from a sponsorship or an author lottery

This far a possible use-cases for __token-as-a-subcription__ :
- exhangable and giftable  subscription
- season pass
- share of sponsorship money
- game tokens
- communty points (karma)
- aviability secure sells sponsorhip content

**Mesh functionality and possabilities described somewhere else**

## Status (important notes for developers)

Crowdsale token (basic implementation) can be created by  `createCrowdsaleToken` - it will deploy Standard Token with given parameters, then it will deploy standard Crowdsale contract with given parameters
and than it will transfer `totalSupply_` to crowdsale contract.
Then you should deploy subscription through `subFactory` contract

**subscription** contract able to deploy through `createSubscription` interface on `SubFactory.sol`
it awaits addresses of owner, chat token and crowdsale of this token.
Subscription contract allow to signIn, signOut from a chat/channel using tokens, which have been bought through crowdsale.
It's also now allow create **sponsorship offer** through `start` function in subscription contract
also have a _ban_ function.

Antispam contract is too raw to deploy

Has not been tested properly yet.



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

## Dynamic price (USD) and Decimals calculation on Frontend side
There is a method to dynamicly calculate `rate` and `decimals` by USD price on frontend side

To do this, take formula
```
Crowdsale mechanics work like 1$=(1*r) tokens.
that mean that
p=1/r
r=1/p
```
therefore we understand, that if we want to set up crowdsale price as 6$ for a token, than `rate=1/6=0.16`
### What about decimals, you ask?
As we undarstand, that Ethereum doesn't support float numbers, we have a problem with correct setting of rate in cases when 1 token is cost bigger than 1$, like when rate should be equal to `0.16`
in such cases we should increase number of decimals in the side we want to move the _point_

In our example, as rate should be setted to 0.16 it is means that we create token with 18+2 decimals value and give rate=16.

**this also means, that frontend intarface should ALWAYS ask about decimals before moving funds**

## Subscription

Subscritption is a basic contract for subscription managment
`signUp` - procceed a `transferFrom` from a msg.sender, taking 1 token for subscription deposit
think about it as "subscription activision".
`signOut` - return token to a user,stopping subscription.
`banUser` - remove user subscription, token return to a crowdsale contract (I'm not really sure what to do with that)

Now for buying sponsorship you should buy channel token first, then open deal dialog

When all details was cleared, sponsor should send `approve` with subscription contract address __then__ he should finalize offer with calling `start` function from subscription contract.
After that author can accept or decline offer.
Note, that lockd  **does not** store in the contract itself and this variable possible should be calculated somewhere else at **backend**

	MoonShard server should recive state updates about subscription through events from this contract.


	`SubFactory` deploy new subscription contracts, receiving addresses of token,chat owner and crowdsale address (for return).

## Subscription and Advertisment sale scenario: How to set up ad price correctly
Let's imagine that we are channel owner and we want to set up a price for commercial in our blog

As far as we decided that our content is free of charge and we want to sell commercial instead of setting paywall for subscribers
In this case we need to set up a lowest price for entry and high price for them who want to buy commercial

Therefore we set up `rate` variable in crowdsale to 100, which will give us token price in USD = 0.001$.
Then we want to sell our commersial by 100$ per one - in this case we should set up price for ad in our subscription contract as
100*100= 10 000 (tokens)

Universale formula for setting up a advertisment price is:

	ad_price = n*r*decimals

	when n = price in USD for commersials
	r = exchange rate between MoonShard token (equal to USD)
	decimals = decimals of user (chat) token.



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
**This part out of date**

1. ``` truffle console ```
2. ``` migrate --reset ```
3. `ST.new("T","tt",9,10000).then(function(ins){ console.log(ins.address);});`- will deploy new ST token from source ST.sol with parameters T as name, tt as symbol, 9 as decimals and 10000 as initial supply.  Copy address return
4. ` var inst= ST.at('past returned address here'); ` - create instance
5.  `inst.symbol.call();`
6. ` var fac = TokenFactory `
7. `fac.deployed().then(function(instance){return instance.createSToken("N","nn",9,10000);}).then(function(result){return result.logs;});` - function createSToken from Factory
8. `fac.deployed().then(function(instance){return instance.createToken("N","nn",9,10000);}).then(function(result){return result.logs;});` - function createToken from Factory (ownable token)
