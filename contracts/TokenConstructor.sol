pragma solidity ^0.4.24;


import "zeppelin-solidity/contracts/token/ERC20/StandardToken.sol";
import "zeppelin-solidity/contracts/ownership/Ownable.sol";


/*
 * BigToken
 *
 * Very simple ERC20 Token example, where all tokens are pre-assigned
 * to the creator. Note they can later distribute these tokens
 * as they wish using `transfer` and other `StandardToken` functions.
 *
 *  simple standard
 */
contract TokenConstructor is StandardToken,Ownable {


  //Constants
    string public name;
    string public symbol;
    uint public decimals;
    uint public INITIAL_SUPPLY;


  //events
    event LogBurn(address indexed owner, uint indexed value);

//Constructor
    constructor(
        uint256 initialSupply,
        string tokenName,
        uint8 decimalUnits,
        string tokenSymbol) {
        INITIAL_SUPPLY = initialSupply;
        totalSupply_ = INITIAL_SUPPLY * 1 ether;
        balances[msg.sender] = INITIAL_SUPPLY * 1 ether;
        name=tokenName;
        decimals=decimalUnits;
        symbol=tokenSymbol;
    }


    function mintToken(address target, uint256 mintedAmount) onlyOwner public {
        balances[target] += mintedAmount;
        totalSupply_ += mintedAmount;
        Transfer(0, owner, mintedAmount);
        Transfer(owner, target, mintedAmount);
    }

    function burnTokens(uint value) onlyOwner public {
        require(value == 0);
        require(balances[msg.sender]<value);
        balances[msg.sender] -= value;
        totalSupply_ -= value;
        LogBurn(msg.sender, value);
    }
}