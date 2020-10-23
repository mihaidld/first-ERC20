// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

//contract deployed at 0x255Cab97fEd72A8CA556f43281a83046C2c6f915

contract TransactionCounter {
    // Name of the counter
    uint256 private _counter;
    
    // Address of the owner, used for administrative and sensitive function.
    address private _ownerAddress;
    
    // Mapping of addresses authorized to call tick()
    mapping(address => bool) private tickers;

    constructor() public
    {
        _counter = 0;
        _ownerAddress = msg.sender;
    }

    // A modifier for checking if the msg.sender is the admin
    modifier onlyAdmin() {
        require(_ownerAddress == msg.sender, "ERC20: Only an admin can perform this action");
        _;
    }
    
    // Increments the counter by 1, and return the new counter value
    function tick() public returns(uint256){
        require(tickers[msg.sender] == true, "ERC20: Only an admin can perform this action");
        return ++_counter;
    }

    // Returns the current value of the counter:
    function getCount() public view returns(uint256){
        return _counter;
    }

    // Adds an address among the admins (authorized to call tick()
    function addTicker(address _ticker) public onlyAdmin {
        tickers[_ticker] = true;
    }
    
    // Removes an address from the admins ((authorized to call tick())
    function delTicker(address _ticker) public onlyAdmin {
        tickers[_ticker] = false;
    }
    
    // Checks if an address is authorized to call tick()
    function getTicker(address _addr) public view returns (bool){
        return tickers[_addr];
    }
}
