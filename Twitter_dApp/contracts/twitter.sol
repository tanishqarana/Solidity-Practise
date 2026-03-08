//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

//1. Create a Twitter Contract
//2. Map account to the tweet made
//3. Create a function to make a tweet 
//4. Create a function to get Tweet

contract twitter{

    //uint public tweetId;

    struct Tweet{
        uint id;
        uint timestamp;
        uint likes;
        string content;
        //add comments array later
    }
    //so here, instead of mapping the address->id->tweet, we map address->Tweet structre that contains : id,tweet,metadata
    //this is simpler than having a mapping inside an already nested mapping 
    //removed the tweetid global var, to make it address specific
    mapping(address => uint) public counter;
    mapping(address => mapping(uint => Tweet)) public tweets;

    function createTweet(string memory _tweet) public{
        uint _id = counter[msg.sender] ;
        tweets[msg.sender][_id] = Tweet({
            id : _id,
            timestamp : block.timestamp,
            likes : 0,
            content : _tweet
        });
        counter[msg.sender]++;
    }

    function getTweet(address owner, uint _id) public view returns(string memory){
        return tweets[owner][_id].content;
    }

    function getAllTweets(address owner) public view returns(string[] memory){
        uint _length = counter[owner];
        //In solidity uninitalised memory arrays should be given a fixed size hence its not working 
        //string[] memory allTweets ;
        string[] memory allTweets = new string[](_length);
        for(uint i = 0; i < _length; i++){
            allTweets[i] = tweets[owner][i].content;
        }
        return allTweets;
    }

    function likeTweet(address owner, uint _id) public {
        tweets[owner][_id].likes ++;
    }

    // mapping(address => mapping(uint => string)) public tweets;
    // mapping(address => uint[]) public ids;

    // function createTweet(string memory tweet) public {
    //     tweets[msg.sender] = tweet;
    // }

    // function get() public view returns(string memory){
    //     return tweets[msg.sender];
    // }

//     function createTweet(string memory _tweet) public {
//         tweets[msg.sender][tweetId] = _tweet;
//         ids[msg.sender].push(tweetId);
//         tweetId++;
//     }

//    function getAllTweets() public view returns(string[] memory){
//     // 1. Find out how many tweets this specific user has
//         uint historyLength = ids[msg.sender].length;
//         // 2. Create a temporary memory array of that exact size
//         string[] memory tweetArr = new string[](historyLength);
//         // 3. Loop through the user's history
//         for(uint i = 0; i < historyLength; i++){
//             // Grab the actual global ID from their history array
//             uint currentId = ids[msg.sender][i];
//             // Use that ID to fetch the text from the mapping, and put it in our temp array
//             tweetArr[i] = tweets[msg.sender][currentId];
//         }

//         return tweetArr;
//    }

//    function getTweet(address owner, uint _id) public view returns(string memory){
//         return tweets[owner][_id] ;
//   }

}