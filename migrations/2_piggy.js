const piggyBank = artifacts.require("piggyBank");

module.exports = function (deployer) {
  deployer.deploy(piggyBank, '0xB895a1770bA6118b84f653E57118A6a61441FbE7');
};