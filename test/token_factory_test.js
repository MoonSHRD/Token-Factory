const TokenFactory = artifacts.require("TokenFactory");
const Token = artifacts.require('Token')

contract('TokenFactory', async (accounts) => {
    let account_one = accounts[0];
    let account_two = accounts[1];

    let NullAddr = "0x0000000000000000000000000000000000000000"
    let Supply = 10000 * 10 ** 18;
    let Decimals =3;
    let Name = "TestCoin";
    let Label = "TST";

    it("Should Create Simple Token", async () => {
        let instance = await TokenFactory.deployed();
        console.log([Name, Label, 18, Supply]);
        let tokenTx = await instance.createToken(Name, Label, 18, Supply, {from: account_one})
        assert.ok(tokenTx.logs.length == 1, "Too many Events");
        const log = tokenTx.logs[0];
        assert.ok(log.event == "TokenCreated");
        assert.ok(log.args._owner == account_one, "Incorrect owner addr");
    });



    it("Should Create Tokensale", async () => {
        let instance = await TokenFactory.deployed();
        let rate  =1;
        let wallet = account_one

        // string _name,
        //     string _symbol, uint8 _decimals,
        //     uint _INITIAL_SUPPLY, uint256 _rate, address _wallet
        // let tokenTx = await instance.createToken(Name, Label, 18, Supply, {from: account_one})

        let  tokenTx =  await instance.createTokensaleToken(Name,Label,Decimals,Supply,rate,wallet,{from:account_one});
        console.log(tokenTx)

    });

    it("Should Get user tokens", async () => {
        let instance = await TokenFactory.deployed();


        let tokens =  await instance.getTokens.call(account_one);
        // console.log(tokens)

        for (let t of tokens){
            console.log(t);
            let token = await  Token.at(t);
            let tx = await token.transferFrom(account_one,account_two,1 * 1e18)
        }


    });




});


