# Passport Control System 

This Solidity smart contract, Passport control system, is designed to manage the creation, revocation, view and renewal of passports on the Ethereum blockchain.

## Description

The Passport control system Solidity smart contract is a decentralized system built on the Ethereum blockchain to manage the lifecycle of a travel passport, including creation, cancellation, view and renewal.

## Getting Started

In this assessment, I have used remix IDE [https://remix.ethereum.org/]

### Executing program

* How to run the program
* Step-by-step bullets
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract PassportManagement {

    enum PassportType { Regular, Diplomatic, Official }

    struct Passport {
        address owner;
        PassportType passportType;
        string name;
        string nationality;
        uint dateOfBirth;
        uint issueDate;
        uint expiryDate;
        bool isValid;
    }

    mapping(uint => Passport) public passports;
    uint public nextPassportId = 1;

    function createPassport(
        address _owner,
        PassportType _passportType,
        string memory _name,
        string memory _nationality,
        uint _dateOfBirth,
        uint _issueDate,
        uint _expiryDate
    ) public {
        passports[nextPassportId++] = Passport(
            _owner, 
            _passportType, 
            _name, 
            _nationality, 
            _dateOfBirth, 
            _issueDate, 
            _expiryDate, 
            true
        );
    }

    function revokePassport(uint _passportId) public {
        require(passports[_passportId].isValid, "Already invalid");
        passports[_passportId].isValid = false;
    }

    function viewPassport(uint _passportId) public view returns (Passport memory) {
        require(passports[_passportId].owner == msg.sender, "Unauthorized");
        return passports[_passportId];
    }

    function renewPassport(uint _passportId, uint _newExpiryDate) public {
        require(passports[_passportId].isValid, "Invalid passport");
        require(passports[_passportId].owner == msg.sender, "Unauthorized");
        passports[_passportId].expiryDate = _newExpiryDate;
    }
}
```

## Authors

Manish Kumar gmail - manishkeshri19509@gmail.com


## License

This project is licensed under the MIT License
