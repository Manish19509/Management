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

    event PassportCreationAttempt(address owner, uint issueDate, uint expiryDate);

function createPassport(
    address _owner,
    PassportType _passportType,
    string memory _name,
    string memory _nationality,
    uint _dateOfBirth,
    uint _issueDate,
    uint _expiryDate
) public {
    emit PassportCreationAttempt(_owner, _issueDate, _expiryDate);
    require(_issueDate < _expiryDate, "Issue date must be before expiry date");

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
        Passport storage passport = passports[_passportId];
        // Check if passport exists and is valid
        require(passport.owner != address(0), "Passport does not exist");
        require(passport.isValid, "Passport is already invalid");
        require(passport.owner == msg.sender, "Unauthorized");

        passport.isValid = false;
    }

    function viewPassport(uint _passportId) public view returns (Passport memory) {
        Passport memory passport = passports[_passportId];
        // Check if passport exists and is valid
        require(passport.owner != address(0), "Passport does not exist");
        require(passport.isValid, "Passport is invalid");
        require(passport.owner == msg.sender || msg.sender == address(0), "Unauthorized"); // Example: Allow anyone to view valid passports

        return passport;
    }

    function renewPassport(uint _passportId, uint _newExpiryDate) public {
        Passport storage passport = passports[_passportId];
        // Check if passport exists and is valid
        require(passport.owner != address(0), "Passport does not exist");
        require(passport.isValid, "Invalid passport");
        require(passport.owner == msg.sender, "Unauthorized");
        require(_newExpiryDate > passport.expiryDate, "New expiry date must be after current expiry date");

        passport.expiryDate = _newExpiryDate;
    }
}
