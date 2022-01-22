//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.10;

import "hardhat/console.sol";

import "@openzeppelin/contracts/access/Ownable.sol";

contract Verifier is Ownable {
    struct UserData {
        uint256 aadharCard;
        uint256 panCard;
    }

    mapping(address => UserData) private userData;
    mapping(address => bool) public hasRegistered;
    mapping(address => bool) private whitelist;

    function addToWhitelist(address _address) public onlyOwner {
        whitelist[_address] = true;
    }

    function registerUser(uint256 _aadharCard, uint256 _panCard)
        public
        returns (bool)
    {
        hasRegistered[msg.sender] = true;
        userData[msg.sender] = UserData(_aadharCard, _panCard);
        return true;
    }

    function modifyUser(uint256 _aadharCard, uint256 _panCard)
        public
        returns (bool)
    {
        if (hasRegistered[msg.sender]) {
            userData[msg.sender].aadharCard = _aadharCard;
            userData[msg.sender].panCard = _panCard;
            return true;
        }
        return false;
    }

    function getUserData(address _user) public view returns (uint256, uint256) {
        if (whitelist[msg.sender]) {
            return (userData[_user].aadharCard, userData[_user].panCard);
        }
        return (0, 0);
    }
}
