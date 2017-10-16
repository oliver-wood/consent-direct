var Test1 = artifacts.require("Test1");

// Test with Mocha
contract('Test1', function(accounts) {
  // Async functions being used here - see https://davidburela.wordpress.com/2017/09/21/writing-truffle-tests-with-asyncawait/
  // An alternate way of doing this without async functions is as follows:
  /* 
  // Check if our instance has deployed
  Test3.deployed().then(function(instance) {
    // Assign our contract instance for later use
    _test3 = instance;
  }) 
  */

  console.log(accounts[0]);

  it("Check that deployed contract is not null", async function() {
    let _contract = await Test1.deployed();
    let _result = (_contract != null);
    assert.isOk(_result);
   })

  it("Test create organisation", async function() {
	const _badOrgName = "undefined";
    let _orgName = _badOrgName; // setting it to a 'bad' value to check against later
    let _contract = await Test1.deployed();
    await _contract.createOrganisation("This is the newly created organisation name");
    //console.log("_orgName [" + _orgName + "]");
    _orgName = await _contract.getOrgName();
    //console.log("_orgName [" + _orgName + "]");
    assert.notEqual(_badOrgName, _orgName, "Org name has not changed");
  })

  it("Test question count increments correctly", async function() {
    let _contract = await Test1.deployed();
    await _contract.createOrganisation("org name");

    // add some questions
    await _contract.addQuestion("Question 1");
    await _contract.addQuestion("Question 2");
    await _contract.addQuestion("Question 3");

    _qc = await _contract.getQuestionCount(accounts[0]);
    assert.equal(3, _qc, "Question count incorrect");
  })

});