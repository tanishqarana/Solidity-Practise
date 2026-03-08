//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

//1. Create a Twitter Contract
//2. Map account to the tweet made
//3. Create a function to make a tweet 
//4. Create a function to get Tweet

contract twitter{

    uint public tweetId = 0;


    mapping(address => mapping(uint => string)) public tweets;
    mapping(address => uint[]) public ids;

    // function createTweet(string memory tweet) public {
    //     tweets[msg.sender] = tweet;
    // }

    // function get() public view returns(string memory){
    //     return tweets[msg.sender];
    // }

    function createTweet(string memory _tweet) public {
        tweets[msg.sender][tweetId] = _tweet;
        ids[msg.sender].push(tweetId);
        tweetId++;
    }

   function getAllTweets() public view returns(string[] memory){
    // 1. Find out how many tweets this specific user has
        uint historyLength = ids[msg.sender].length;
        // 2. Create a temporary memory array of that exact size
        string[] memory tweetArr = new string[](historyLength);
        // 3. Loop through the user's history
        for(uint i = 0; i < historyLength; i++){
            // Grab the actual global ID from their history array
            uint currentId = ids[msg.sender][i];
            // Use that ID to fetch the text from the mapping, and put it in our temp array
            tweetArr[i] = tweets[msg.sender][currentId];
        }

        return tweetArr;

   }

}