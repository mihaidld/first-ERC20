# **First ERC20**

### _Steps_ :

_TransactionCounter.sol_  
Deploy contract and copy contract address

_FirstERC20.sol_  
Deploy contract with address of `TransactionCounter` contract and copy contract address

_FirstIco.sol_  
Deploy with address of `FirstERC20` contract

_TransactionCounter.sol_  
Approve FirstERC20 address by calling _addTicker_ function with the address of `FirstERC20` contract

_FirstERC20.sol_  
Approve FirstIco address by calling _approve_ function with the address of `FirstIco` contract and a maximum amount allowed to `FirstIco` contract responsible for selling tokens
