pragma solidity ^0.4.4;

contract Test1 {

   struct questionsStruct {
       string question;
       // possible answers
   }

   struct organisationData {
       string name;
       uint questionCount;
       string []questions;
   }


   mapping (address=>organisationData) public OrgData;

  // mapping (address=>questionsStruct[]) public Questions;
   
   function Test1() public {
     // constructor
   }
   
   function setName(string name) public {
       OrgData[msg.sender].name = name;
   }
   function addQuestion(string questionToAdd) public {
       OrgData[msg.sender].questions.push(questionToAdd);
       OrgData[msg.sender].questionCount++;
   }

  function getQuestionCount() constant public returns (uint) {
      return OrgData[msg.sender].questionCount;
  }

  function getQuestionCount(address owner) constant public returns (uint) {
      return OrgData[owner].questionCount;
  }

  function getQuestion(uint questionNumber) constant public returns (string) {
      return OrgData[msg.sender].questions[questionNumber];
  }
  
  function getQuestion(address owner, uint questionNumber) constant public returns (string) {
      return OrgData[owner].questions[questionNumber];
  }
    
}

