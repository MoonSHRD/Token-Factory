var Contracts = artifacts.require("./TokenFactory.sol");

module.exports = function(deployer) {
  deployer.deploy(Contracts);
};
