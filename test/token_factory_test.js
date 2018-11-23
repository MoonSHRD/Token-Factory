const TokenFactory = artifacts.require("TokenFactory");
const Token = artifacts.require('Token');
const Community = artifacts.require('Community');

contract('TokenFactory', async (accounts) => {
    const owner = accounts[0],
        wallet = accounts[1],
        Supply = 10000 * 10 ** 18,
        Decimals = 3,
        Name = "TestCoin",
        Label = "TST",
        rate = 1;
    let Instance;

    before(async () =>{
        Instance = await TokenFactory.deployed();
    })

    describe("Create Community and Token", async () => {

        it("Should Create Community with Token", async () => {
            const communityToken = await Instance.createCommunityToken(Name, Label, Decimals, Supply, rate, owner, {from: owner});
            const logOne = communityToken.logs[0];
            const logTwo = communityToken.logs[1];
            assert.ok(logOne.event == "TokenCreated");
            assert.ok(logTwo.event == "CommunityTokenCreated");
        });

        it("Should Create Community without Token", async () => {
            const community =  await Instance.createCommunity(owner, {from: owner});
            const log = community.logs[0];
            assert.ok(log.event == "CommunityNoTokenCreated");
        })
    }) 






});


