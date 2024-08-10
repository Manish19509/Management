# Passport Control System 

This Solidity smart contract, Passport control system, is designed to manage the creation, revocation, view and renewal of passports on the Ethereum blockchain.

## Description

The Passport control system Solidity smart contract is a decentralized system built on the Ethereum blockchain to manage the lifecycle of a travel passport, including creation, cancellation, view and renewal.

## Getting Started

In this assessment, I have used remix IDE [https://remix.ethereum.org/]

### Executing program

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
To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.7" (or another compatible version), and then click on the "Compile AccountManagement.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "Passport Control System" contract from the dropdown menu, and then click on the "Deploy" button.

## Authors

Manish Kumar - (https://www.linkedin.com/in/manish-kmr/)


## License

This project is licensed under the MIT License
