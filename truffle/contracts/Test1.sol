pragma solidity ^0.4.4;

contract Test1 {

   struct organisationData {
       string name;
       State currentState;
       uint questionCount;
       string []questions;
       bool isAvailable;
   }

  enum State { Development, Live, Archived }
  
   address contractOwner;
   mapping (address=>organisationData) public OrgData;


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
   
   modifier ifValidOrganisation() {
       if (OrgData[msg.sender].isAvailable ) {
           _;
       } else {
           revert();
       }
   }

   modifier ifInDevelopmentState() {
       if (OrgData[msg.sender].currentState == State.Development ) {
           _;
       } else {
           revert();
       }
   }

   
   function createOrganisation(string name) ifCreator() public {
       OrgData[msg.sender].name = name;
       OrgData[msg.sender].currentState = State.Development;
       OrgData[msg.sender].isAvailable = true;
   }

   function setStateToLive() ifValidOrganisation() public {
       OrgData[msg.sender].currentState = State.Live;
   }



   function addQuestion(string questionToAdd) ifValidOrganisation() ifInDevelopmentState() public {
       OrgData[msg.sender].questions.push(questionToAdd);
       OrgData[msg.sender].questionCount++;
   }

  function getQuestionCount() constant public returns (uint) {
      return OrgData[msg.sender].questionCount;
  }

  function getQuestionCount(address owner) constant public returns (uint) {
      return OrgData[owner].questionCount;
  }

  function getQuestion(uint questionNumber) ifValidOrganisation() constant public returns (string) {
      return OrgData[msg.sender].questions[questionNumber];
  }
  
  function getQuestion(address owner, uint questionNumber) constant public returns (string) {
      return OrgData[owner].questions[questionNumber];
  }
    
}




contract Test2 {
    //Test1 t1 = Test1(0x62dc125741851e1e9a3d9e6623652e93b31ce8f2);

    struct userResponse {
        address questionSetOwner;
        bool[] answers;
    }

    struct user {
        string userId; // could be email address or email hash
        userResponse[] userResponses;
        bool isCreated;
    }

    mapping(address=>user) users;
    
    // register a new user account - only called once per user
    function registerUser(string _userId) public {
        user thisUser = users[msg.sender];
        if(thisUser.isCreated) {
            revert();
        }
        
        thisUser.userId = _userId;
        thisUser.isCreated = true;
    }

    function isRegisteredUser(string _userId) public {
        // 
    }
    

}

