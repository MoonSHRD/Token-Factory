pragma solidity ^0.4.24;
import "zeppelin-solidity/contracts/token/ERC20/StandardToken.sol";
import "zeppelin-solidity/contracts/ownership/Ownable.sol";

contract Token is StandardToken, Ownable {
    string public name;
    string public symbol;
    uint8 public decimals;
    address public Factory;
    
    constructor(string _name,
    string _symbol,
    uint8 _decimals,
    uint _INITIAL_SUPPLY,
    address _owner) public {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply_ = _INITIAL_SUPPLY;
        Factory = msg.sender;
        owner = _owner;
        balances[owner] = totalSupply_;
    }
}