// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
import "./FirstErc20.sol";

//contract deployed at 0xf13c61824480e52796a378969F9a262021D0E386

contract FirstIco {
    // Declare a FirstErc20 contract
    FirstErc20 public token;

    // The price of 1 unit of our token in wei;
    uint256 public _price;

    // Address of token seller
    address payable private _seller;

    constructor(uint256 price, address erc20Address ) public {
        _price = price;
        //Token is deployed at 0x5F3215c30432d2c481BA56b0F7Fa34375cb079A4
        token = FirstErc20(erc20Address);
        _seller = token.getOwner();
    }

    // receive external function payable which handles automatically the receipt of ether inside the contract from user, is called when the amount is sent by the user
    receive() external payable {
        buy(msg.value/_price);
/*        require(msg.value >= 0, "ICO: Price is not 0 ether");
        uint nbTokens = msg.value / _price;
        token.transferFrom(_seller, msg.sender, nbTokens);
        _seller.transfer(msg.value);*/
    }

    function buy(uint256 nbTokens) public payable returns(bool){
        require(msg.value >= 0, "ICO: Price is not 0 ether");
        require(nbTokens * _price <= msg.value, "ICO: Not enough Ether for purchase");
        uint256 _realPrice = nbTokens * _price;
        uint256 _remaining = msg.value - _realPrice;
        token.transferFrom(_seller, msg.sender, nbTokens);
        _seller.transfer(_realPrice);
        if(_remaining > 0) {
            msg.sender.transfer(_remaining);
        }
        return true;
    }
}