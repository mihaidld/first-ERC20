// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
contract TransactionCounter {
    // Name of the counter
    uint256 private _counter;
    
    // Address of the owner, used for administrative and sensitive function.
    address _ownerAddress;
    
    // Mapping of addresses authorized to call tick()
    mapping(address => bool) tickers;

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
    function addTicker(address _ticker) public onlyAdmin returns (bool){
        tickers[_ticker] = true;
        return true;
    }
    
    // Removes an address from the admins ((authorized to call tick())
    function delTicker(address _ticker) public onlyAdmin returns (bool){
        tickers[_ticker] = false;
        return true;
    }
}
