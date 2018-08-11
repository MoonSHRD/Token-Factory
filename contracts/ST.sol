
pragma solidity ^0.4.24;
import "zeppelin-solidity/contracts/token/ERC20/StandardToken.sol";

contract ST is StandardToken {

string public name;
string public symbol;
uint8 public decimals;


constructor(string _name,
string _symbol,
uint8 _decimals,
uint _INITIAL_SUPPLY) public {
    name = _name;
    symbol = _symbol;
    decimals = _decimals;
    totalSupply_ = _INITIAL_SUPPLY;
    balances[msg.sender] = totalSupply_;
  //  balances[sender] = totalSupply_;
}
}
