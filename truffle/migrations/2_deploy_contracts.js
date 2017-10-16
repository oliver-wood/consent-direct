var ConvertLib = artifacts.require("./ConvertLib.sol");
//var Test1 = artifacts.require("./Test1.sol");

var Test1 = artifacts.require("Test1");
var Test2 = artifacts.require("Test2");
var Test3 = artifacts.require("Test3");
var Test4 = artifacts.require("Test4");

module.exports = function(deployer) {
  deployer.deploy(ConvertLib);

 deployer.deploy(Test1);
 deployer.deploy(Test2);
 deployer.deploy(Test3);
 deployer.deploy(Test4);
};
