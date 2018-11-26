var TokenFactory = artifacts.require("TokenFactory.sol");
var SubFactory = artifacts.require("SubFactory.sol");
var CommunityFactory = artifacts.require("CommunityFactory.sol");

module.exports = function(deployer) {
  deployer.deploy(TokenFactory)
  .then(TokenFactory.deployed)
  .then(factory => deployer.deploy(CommunityFactory, factory.address))
  .then(CommunityFactory.deployed);
 // deployer.deploy(SubFactory);
};

