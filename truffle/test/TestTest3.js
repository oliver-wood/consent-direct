var Test3 = artifacts.require("Test3");
/*
contract('Test3', function(accounts) {
	
it("Test question count", function() {
	var test = 
	return Test3.deployed().then(function(instance){ 
		test = instance;
		
		
		
	var qc = test.getQuestionCount();
	assert.equal(qc, 0, "All OK");	
});

});
*/


contract('Test3', function(accounts) {
	  it("should assert true",function() {
	    return Test3.deployed().then(function(instance) {
		  return instance.getQuestionCount();
		}).then(function(_qc) {
			assert.equal(_qc, 0,"Value is ");	
	    });
	  });
	});




/*
contract('Calculator',function(accounts) {
  it("should assert true",function() {
    var calculator;
    return Calculator.deployed().then(function(instance){
      calculator =instance;
      return calculator.getResult.call();
    }).then(function(result){
      assert.equal(result.valueOf(),10,"Contract initialized with ");
      calculator.addToNumber(10);
      calculator.subtractFromNumber(5);
      return calculator.getResult.call();
    }).then(function(result){
      assert.equal(result.valueOf(),15,"Contract initialized with ");
    });
  });
});

*/