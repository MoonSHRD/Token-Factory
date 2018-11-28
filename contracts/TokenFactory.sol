pragma solidity ^0.4.24;


import "./Token.sol";
import "./Community.sol";


contract TokenFactory {


    address god;
    
    event TokenCreated(address _owner, address _token);

    // define zheton as Token contract. There is might be a pitfall, cause tokensale await ERC20
  //  Token public zheton;
    constructor() public {
        god = msg.sender;
    }

    modifier onlyGod(){
        require(msg.sender != god);
        _;
    }

    function changeAdresses(address _god) public onlyGod {
        god = _god;
    }

// function that create Simple Token without Community
// Returns Token object with new address
    function createToken(string _name,
    string _symbol,
    uint8 _decimals,
    uint _INITIAL_SUPPLY,
    address _owner) public returns (Token) {

        Token token = new Token(_name, _symbol, _decimals, _INITIAL_SUPPLY, _owner);      
        emit TokenCreated(msg.sender, address(token));

        return token;
    }
}

