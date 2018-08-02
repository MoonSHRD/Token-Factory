pragma solidity ^0.4.24;


import "./Token.sol";


contract TokenFactory {
    address god;
    mapping (address => address[]) public tokens;

    constructor() public {
        god = msg.sender;
    }

    modifier onlyGod(){
        require(msg.sender != god);
        _;
    }

    event TokenCreated(address owner, address token);

    function changeAdresses(address _god) public onlyGod {
        god = _god;
    }
/*
    function createSToken(string _name,
    string _symbol,
    uint8 _decimals,
    uint _INITIAL_SUPPLY) public returns(address) {
    address token = 0x0;

          token = address(new ST(_name,_symbol,_decimals,_INITIAL_SUPPLY));

    //    tokens[msg.sender].push(token);
        emit TokenCreated(msg.sender, token);
       return token;

    }
*/

/*  Appendix

    function createCrowdsaleToken(){



    }
*/

// Function that create Token, crowdsale contract and start it at once
// Note that it can be burn a lot of gas, so I think we need to split this function in the future
function createToken(string _name,
string _symbol,

uint _INITIAL_SUPPLY) public returns(address) {
address token = 0x0;
    token = address(new Token(_name, _symbol, _INITIAL_SUPPLY, msg.sender));

    tokens[msg.sender].push(token);
    emit TokenCreated(msg.sender, token);
   return token;

}




/* function that create Simple Token without crowdsale
    function createToken(string _name,
    string _symbol,

    uint _INITIAL_SUPPLY) public returns(address) {
    address token = 0x0;
        token = address(new Token(_name, _symbol, _INITIAL_SUPPLY, msg.sender));

        tokens[msg.sender].push(token);
        emit TokenCreated(msg.sender, token);
       return token;

    }
*/

    function getTokens(address _owner) view public returns(address[]) {
        return tokens[_owner];
    }
}
