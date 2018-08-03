var TFactory = artifacts.require("./TokenFactory.sol");
var SFactory = artifacts.require("./SubFactory.sol");

module.exports = function(deployer) {
  deployer.deploy(TFactory);
  deployer.deploy(SFactory);
};
