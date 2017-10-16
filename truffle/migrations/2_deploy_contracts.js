var ConvertLib = artifacts.require("./ConvertLib.sol");
//var Test1 = artifacts.require("./Test1.sol");

var Test1 = artifacts.require("Test1");
var Test2 = artifacts.require("Test2");

module.exports = function(deployer) {
  deployer.deploy(ConvertLib);

 deployer.deploy(Test1);
 deployer.deploy(Test2);
};
