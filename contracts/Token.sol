pragma solidity ^0.4.24;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/StandardToken.sol";


contract Token is StandardToken, Ownable {
    string public name;
    string public symbol;
    uint8 public decimals;
    address public Factory;
    // prepare URANUS
    // probably need to reafactor it to a modifier
    bool public prepared = false;

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
        //balances go to the owner normally
        // Keep closed if we want to transfer tokens to the crowdsale
      //  balances[owner] = totalSupply_;

    }

    modifier onlyFactory(){
        require(msg.sender != Factory);
        _;
    }

   function prepareCrowdsale(address _crowdsale) public onlyFactory{
     require(prepared == false);
     balances[_crowdsale] = totalSupply_;
     prepared = true;


   }

/*
    NOTE  BUG found - when you try to implement function below
    solidity compiler with truffle will CRUSH, killing truffle location map with
    it. Don't know why is it happening, but obviously it is not expected
    behavior

    Example of exeption I got:
    'truffle compile
Error parsing /home/jack/ethProjects/Token-Factory/contracts/Token.sol: ParsedContract.sol:55:1: ParserError: Function, variable, struct or modifier declaration expected.
import '__Truffle__NotFound.sol';
^----^
'


   function askDecimals() public returns (uint8){
   uint8 result = decimals;
   return result;
*/



}
