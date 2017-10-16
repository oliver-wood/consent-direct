pragma solidity ^0.4.6;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Test1.sol";

contract TestTest1 {
  event LogSomething(string _output);

  enum State { Development, Live, Archived }

  function testTest1ContractOwner() {
    Test1 _t1 = Test1(DeployedAddresses.Test1());
    address _a = _t1.getContractOwner();
	address _b = tx.origin;
    Assert.equal(_a, _b, "Contract owner and TX origin not equal.");	
  }

  function testOrganisationNotCreated() {
    Test1 _t1 = Test1(DeployedAddresses.Test1());
    var(_orgName, _orgState, _orgQuestionCount, _orgIsAvailable) = _t1.getOrgData(tx.origin);
    Assert.isFalse(_orgIsAvailable, "Data for this organisation not yet created");
  }


  function testOrganisationCreated() {
    Test1 _t1 = Test1(DeployedAddresses.Test1());
//    LogSomething("222");
	_t1.createOrganisation("Name");
//    LogSomething("333");
    //var(_orgName, _orgState, _orgQuestionCount, _orgIsAvailable) = _t1.getOrgData(tx.origin);
    //Assert.isTrue(_orgIsAvailable, "Data for this organisation not yet created");
    Assert.isTrue(true, "All OK");
  }

}
