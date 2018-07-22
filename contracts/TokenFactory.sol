pragma solidity ^0.4.24;
 import "./ST.sol";
//import "zeppelin-solidity/contracts/token/ERC20/StandardToken.sol";
//import "./StandardToken.sol";
//import "./Token.sol";


contract TokenFactory {
    address dao;
    mapping (address => address[]) public tokens;

    constructor() public {
        dao = msg.sender;
    }

    modifier onlyDao(){
        require(msg.sender != dao);
        _;
    }

    event TokenCreated(address owner, address token);

    function changeAdresses(address _dao) public onlyDao {
        dao = _dao;
    }

    function createToken(string _name,
    string _symbol,
    uint8 _decimals,
    uint _INITIAL_SUPPLY) public returns(address) {
    address token = 0x0;
    //    token = address(new Token(_name, _symbol, _decimals, _INITIAL_SUPPLY, msg.sender));
          token = address(new ST(_name,_symbol,_decimals,_INITIAL_SUPPLY));
  //  token = new ST(_name,_symbol,_decimals,_INITIAL_SUPPLY);
    //    tokens[msg.sender].push(token);
        emit TokenCreated(msg.sender, token);
       return token;

    }

    function getTokens(address _owner) view public returns(address[]) {
        return tokens[_owner];
    }
}
