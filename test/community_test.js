const TokenFactory = artifacts.require("TokenFactory");
const Token = artifacts.require('Token');
const Community = artifacts.require('Community');

contract('Community', async (accounts) => {
    const owner = accounts[0],
        wallet = accounts[1],
        Supply = 10000 * 10 ** 18,
        Decimals = 3,
        Name = "TestCoin",
        Label = "TST",
        rate = 1;
    let Instance,
        token,
        community;


    before(async function () {
        const Instance = await TokenFactory.deployed();
        await Instance.createCommunityToken(Name, Label, Decimals, Supply, rate, owner, {from: owner});
        community = (await Community.at((await Instance.getCommunitys.call(owner))[0]));
        token = (await Token.at((await Instance.getTokens.call(owner))[0]));;
    })
    describe("Owner", async () => {
        
        it("Owner should prepare Community to TokenSale", async () => {
            await community.prepareCommunity({from: owner});

            assert.equal((await token.balanceOf(community.address)).toNumber(), 
                        (await token.totalSupply.call()).toNumber(), "tokens was not recieved");
        })
    })    
    describe("User", async () => {

        it("Should buy tokens from Community", async () => {
                
            await community.sendTransaction({from: wallet, to: community.address, value: 1000000});

            const walletTokensAfter = await token.balanceOf(wallet);
            const communityBalanceAfter = await web3.eth.getBalance(community.address);

            assert.equal(walletTokensAfter, 1000000,'tokens were not received by the wallet');
            assert.equal(communityBalanceAfter, 1000000,'weiAmount was not received by contract');
        })

        it("Should be able to transfer tokens", async () => {

            await token.approve(owner, 1000, {from: wallet})  ;
            await token.transferFrom(wallet, owner, 1000, {from: owner});
            assert.equal((await token.balanceOf(owner)), 1000, "tokens was not received");  
            
        });
    })
})    