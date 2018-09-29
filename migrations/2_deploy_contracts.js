var TokenFactory = artifacts.require("TokenFactory.sol");
var SubFactory = artifacts.require("SubFactory.sol");

module.exports = function(deployer) {
  deployer.deploy(TokenFactory);
  deployer.deploy(SubFactory);
};
