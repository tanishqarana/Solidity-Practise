#Solidity Practice: Decentralized Twitter 🐦
This repository contains my foundational smart contracts for Web3 backend development. The primary project is a decentralized Twitter-like protocol built with Solidity, focusing on gas-efficient state management and data retrieval.

##Overview
The Twitter contract allows users to post text-based "tweets" that are permanently recorded on the blockchain. The architecture ensures that users have ownership of their data and is structured to prevent the high gas costs typically associated with reading dynamic arrays in Ethereum.

##Core Features
###Create Tweets
    Users can publish tweets, which are automatically linked to their Ethereum wallet address (msg.sender).

###Automated ID Generation
    The contract utilizes a global, auto-incrementing state variable to assign mathematically predictable, collision-free IDs to every new tweet.

###Efficient Data Retrieval
    Users can fetch their entire tweet history in a single transaction without hitting block gas limits.

##Architecture & Data Structures
To optimize storage and read complexity, this contract avoids the anti-pattern of mapping addresses directly to dynamic arrays of strings (string[]). Instead, it uses a decoupled "Mapping + Array" approach:

The Data Mapping: mapping(address => mapping(uint => string))
Provides fast lookup time for the actual text data, anchored to a specific Tweet ID.

The History Array: mapping(address => uint[])
Stores lightweight integers (uint) representing the IDs of the tweets a user has made.

Memory Array Retrieval: The returnAllTweets() function initializes a fixed-size string[] memory array to safely iterate and return the user's history in one read operation.

##Technologies Used
Language: Solidity ^0.8.0

Environment: Remix IDE / EVM Testnet