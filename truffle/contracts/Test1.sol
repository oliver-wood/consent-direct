pragma solidity ^0.4.6;

contract Test1 {

  event LogSomething(string _output);

  enum State { Development, Live, Archived }

  // a single 'organisation' and their set of questions
  struct organisationData {
    string name;
    State currentState; // dev/live/archived
    uint questionCount; // items in questions array
    string []questions;
    bool isAvailable; // used to just test if an organisation has been added
  }
  
  address public contractOwner = msg.sender; // who created this contract (public implicitely gives get/set functionality)
  address public contractAdmin = msg.sender; // an account that can perform admin/owner type actions on the contract. Default to contract creator
  uint public contractCreationTime = block.timestamp;


  // each account has a single 'organisation'
  mapping (address=>organisationData) public orgData;

  // constructor
  function Test1() public {
      LogSomething("Contract created");
  }

  function setContractAdmin(address _newAdmin) public ifCreatorOrAdmin() {
      contractAdmin = _newAdmin;
  }

  modifier ifCreatorOrAdmin() {
    // be aware that if testing this contract via truffle test this modifier may fail.
    // see https://ethereum.stackexchange.com/questions/25088/truffle-why-is-my-onlyowner-modifier-not-running-in-truffle/25128
    // This is because msg.sender will be the name of the TestTest.sol contract rather than an account    
    // LogSomething("> ifCreatorOrAdmin modifier");
    address _msgSender = msg.sender; // just for debug purposes - so I can see the variables
    address _contractOwner = contractOwner; // just for debug purposes - so I can see the variables

    if ( (msg.sender==contractOwner) || (msg.sender==contractAdmin)) {
      _;
    } else {
      revert();
    }
  }
   
  // check if the organisation identified by their address alread has a question set
  modifier ifValidOrganisation() {
    if (orgData[msg.sender].isAvailable ) {
      _;
    } else {
      revert();
    }
  }

  // check if current organisation is in a development state (i.e., can have new questions added)
  modifier ifInDevelopmentState() {
    if (orgData[msg.sender].currentState == State.Development ) {
      _;
    } else {
      revert();
    }
  }
 
  // TODO: decide what to do here - if a set of questions already exists
  // for an organistion this will just overwrite the exist details - perhaps
  // it should not even be allowed????
  function createOrganisation(string _name) ifCreatorOrAdmin() public {
    orgData[msg.sender].name = _name;
    orgData[msg.sender].currentState = State.Development;
    orgData[msg.sender].questionCount = 0;
    orgData[msg.sender].isAvailable = true;
  }

  // Move from dev (or other state) to live. You can only set yor own details to live.
  function setStateToLive() ifValidOrganisation() public {
    orgData[msg.sender].currentState = State.Live;
  }

  // add new questions - only if the question set is in development state
  function addQuestion(string _questionToAdd) ifValidOrganisation() ifInDevelopmentState() public {
    orgData[msg.sender].questions.push(_questionToAdd);
    orgData[msg.sender].questionCount++;
  }

  function getQuestionCount() constant public returns (uint) {
    return orgData[msg.sender].questionCount;
  }

  function getQuestionCount(address _owner) constant public returns (uint) {
    return orgData[_owner].questionCount;
  }

  function getQuestion(uint _questionNumber) ifValidOrganisation() constant public returns (string) {
    return orgData[msg.sender].questions[_questionNumber];
  }
  
  function getQuestion(address _owner, uint _questionNumber) constant public returns (string) {
    return orgData[_owner].questions[_questionNumber];
  }

  function getOrgName() constant public returns (string) {
      return(orgData[msg.sender].name);
  }
  
  function getOrgData(address _owner) constant public returns (string, uint, uint, bool) {
      return(orgData[_owner].name, uint(orgData[_owner].currentState), orgData[_owner].questionCount, orgData[_owner].isAvailable);
  }
}



// This contract is managed and controlled by a single contract owner.  For a given user
// (indexed by a unique identifier) it will store a list of organisation addresses (an org
// contains the questions) and the answers.
contract Test2 { 
  //Test1 t1 = Test1(0x62dc125741851e1e9a3d9e6623652e93b31ce8f2);

  address contractOwner; // who created this overall contract
  
  function Test2() public {
    contractOwner = msg.sender;
  }

  modifier ifCreator() {
    if (msg.sender == contractOwner) {
      _;
    } else {
      revert();
    }
  }

  struct userResponse {
    address questionSetOrganisation; // organisation who owns the questions
    bool[] answers;
  }

  struct user {
    string userIdentifier; // could be email address or email hash
    userResponse[] userResponses;
    mapping(address=>userResponse) userResponseMap;
    bool isCreated;
  }
  
  

//    mapping(address=>user) users;
  mapping(string=>user) users;
    
  // register a new user account - only called once per user
  function registerUser(string _userId) ifCreator() public {
//        user storage thisUser = users[msg.sender]; // get the user from the map of users
    user storage thisUser = users[_userId]; // get the user from the map of users
    if(thisUser.isCreated) {
      revert();
    }
        
    thisUser.userIdentifier = _userId; // store the new users identifier
    thisUser.isCreated = true; // mark as created
  }

  function registerOrganisationForUser(string _userId, address _organisationAddress) ifCreator() public {
    bool[] memory userA;
    userResponse memory userR = userResponse(_organisationAddress, userA);
    userR.questionSetOrganisation = _organisationAddress;
    users[_userId].userResponses.push(userR);
  }

  function getUserResponse(string _userId, address _organisationAddress, uint _questionNumber) ifCreator() public returns (bool) {
    // for the user calling this contract, get the responses for the given organisation address
   user u = users[_userId];
   userResponse ur = u.userResponseMap[_organisationAddress];
   bool ura = ur.answers[_questionNumber];
   return ura;
  }

  function isRegisteredUser(string _userId) ifCreator() public constant returns (bool) {
    user storage thisUser = users[_userId];
    return thisUser.isCreated;
  }

  // register an answer for a question - can only be done if a question set is not in development (or indeed exists)
  function registerAnswer(address questSetOrganisation) ifCreator() public {//, string question, bool answer) ifQuestionsLive() public {
  }

  /*function testQuestionCount(address _contractAddress, address _organisationAddress) public returns (uint) {
    Test1 _t1 = Test1(_contractAddress);
    _t1.createOrganisation("Test Org Name");
	uint _count = _t1.getQuestionCount(_organisationAddress);
	return _count;
  }*/


}

