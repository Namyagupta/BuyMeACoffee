//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract BuyMeACoffee {
    //event to emit when memo is created
    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message
    );

    //Memo struct
    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }

    //List of all memos received from friends
    Memo[] memos;

    //Address of contract deployer
    address payable owner;

    //deploy logic
    constructor() {
        owner = payable(msg.sender);
    }

    /**
     * @dev buy a coffee for contract owner
     * @param _name name of the coffee buyer
     * @param _message a nice message from coffee buyer
     */

    function buyCoffee(string memory _name, string memory _message)public payable{ 
        require(msg.value > 0, "Can't buy coffee with 0 eth");
        memos.push(
          Memo(msg.sender, 
            block.timestamp, 
            _name, 
            _message
        ));

        //emit a log event when a new memo is created
        emit NewMemo(
            msg.sender, 
            block.timestamp, 
            _name, 
            _message
        );
    }
    /**
     * @dev send the balance stored to the owner
     */
    function withdrawTips() public{
        require(owner.send(address(this).balance));
    }
    /**
     * @dev retreive all memos received and stored on the blockchain 
     */
    function getMemos() public view returns (Memo[] memory){
        return memos;
    }

}
