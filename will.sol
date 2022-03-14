//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.5.7;

contract Will{
    address owner;
    uint fortune;
    bool deceased;

    constructor() payable public {
        owner =msg.sender;//msg sender represents address that is being called
        fortune=msg.value ;//msg value tells us how much ether is being sent
        deceased=false;
    }

        //create modifier so the only person can call the contract

        modifier onlyOwner{
            require(msg.sender == owner);
            _;
        }

        //create modifier so that we only allocate funds if friend's gramps deceased
         modifier mustbeDeceased{
            require(deceased == true );
            _;
        }


    //list of family wallets
    address payable[] familyWallets;


    //map through inheritance
    mapping(address => uint)inheritance;

    function setInheritance(address payable wallet,uint amount) public{
        familyWallets.push(wallet);
        inheritance[wallet]=amount; 
    }

    //pay each member based on wallet address

     function payout() private mustbeDeceased{
         for(uint i=0;i<familyWallets.length;i++ )
         {
             familyWallets[i].transfer( inheritance[familyWallets[i]]);
             //transferring the funds from contract adress to reciever address
              
         }
     }



     function hasdeceased() public onlyOwner{
         deceased= true;
         payout();
     }



        





    



     





}




