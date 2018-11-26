const CommunityFactory = artifacts.require("CommunityFactory");
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
        Instance = await CommunityFactory.deployed();
    })

    describe("Create Community and Token", async () => {

        it("Should Create Community with Token", async () => {
            const communityToken = await Instance.createCommunityToken(Name, Label, Decimals, Supply, rate, owner, {from: owner});
            const log = communityToken.logs[0];
            assert.ok(log.event == "CommunityTokenCreated");
        });

        it("Should Create Community without Token", async () => {
            const community =  await Instance.createCommunity(owner, {from: owner});
            const log = community.logs[0];
            assert.ok(log.event == "CommunityNoTokenCreated");
        })

        it("Should be able to see tokens addresses of the owner", async () => {
            const tokens = await Instance.getTokens.call(owner);
            assert.equal(tokens.length, 1, "owners tokens are not visible")
        })

        it("Should be able to see communitys addresses of the owner", async () => {
            const communitys = await Instance.getCommunitys.call(owner);
            assert.equal(communitys.length, 2, "owners communitys are not visible")
        })

        it("Should be able to check presence of owner tokens", async () => {
            const tokens = await Instance.hasTokens.call(owner);
            assert.equal(tokens, true, "owners tokens are not visible")
        })

        it("Should be able to check presence of owner communitys", async () => {
            const communitys = await Instance.hasCommunitys.call(owner);
            assert.equal(communitys, true, "owners communitys are not visible")
        })
    }) 






});


