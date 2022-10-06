// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; 

// contract address = '0x760D40652427449867406Cee8798722989afd6D3'

contract piggyBank {
    address payable immutable piggy;

    constructor(address payable _piggy) {
        piggy = _piggy;
    }

    error failed();

    mapping(address => uint) public ledger;

    address payable[] piggyUsers;

    enum Post {
        save,
        withdraw
    }

    event log(Post indexed post);

    uint private timelock;

    struct savingInfo {
        uint amount;
        uint deadline;
        uint interval;
    } 

    mapping(address => savingInfo) public usersInfo;
    savingInfo information;
    uint timing;
    mapping (address => uint) public userInterval;

    function setAccount(address payable saver, uint _amount, uint _deadline, uint _timing) external {
        piggyUsers.push(saver);
        information = savingInfo(_amount, _deadline, block.timestamp); 
        usersInfo[saver] = information; 
        timing = _timing;
        userInterval[saver] = timing;      
    }
uint[] aago;
 function save(address payable saver, uint amount) external payable {  
     aago.push(block.timestamp); 
      for(uint i = 0; i < aago[aago.length-2]; i++) 
        require(block.timestamp > aago[i] + userInterval[saver]);
         require(saver == msg.sender);
         require(amount == usersInfo[saver].amount);
         for(uint i = 0; i < piggyUsers.length; i++) {
             if(piggyUsers[i] == saver) {
                 ledger[saver] = amount;
                 piggy.transfer(amount);
                 emit log(Post.save);
                 usersInfo[saver].deadline--;
             } else {
                 revert failed();
             }
         }
}

       modifier onlyAdmin() {
        require(msg.sender == piggy);
           _;
       }

   function withdraw(address payable owner, uint amt) external onlyAdmin payable {
       require(amt == ledger[owner]);
       require(usersInfo[owner].deadline == 0);
       owner.transfer(amt);
   }
}

