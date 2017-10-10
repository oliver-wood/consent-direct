pragma solidity ^0.4.14;

contract Test1 {

  enum State { Development, Live, Archived }

  // a single 'organisation' and their set of questions
  struct organisationData {
    string name;
    State currentState; // dev/live/archived
    uint questionCount; // items in questions array
    string []questions;
    bool isAvailable; // used to just test if an organisation has been added
  }
  
  address contractOwner; // who created this overall contract
  
  // each account has a single 'organisation'
  mapping (address=>organisationData) public orgData;

  function Test1() public {
    contractOwner = msg.sender;
  }

  modifier ifCreator() {
    if (msg.sender == contractOwner) {
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
 
  function createOrganisation(string _name) ifCreator() public {
    orgData[msg.sender].name = _name;
    orgData[msg.sender].currentState = State.Development;
    orgData[msg.sender].isAvailable = true;
  }

  // move from dev (or other state) to live
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

}

