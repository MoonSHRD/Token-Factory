pragma solidity ^0.4.24;
import "./StandardToken.sol";
import "./Ownable.sol";

contract TestToken is StandardToken, Ownable {
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

contract TokenFactory {
    address dao;
    mapping (address => address[]) public tokens;
    
    constructor() public {
        dao = msg.sender;
    }
    
    modifier onlyDao(){
   if (msg.sender != dao) {
        revert();
        }
    _;
    }
    
    event TokenCreated(address owner, address token);

    function changeAdresses(address _dao) public onlyDao {
        dao = _dao;
    }
    
    function mintToken(string _name,
    string _symbol,
    uint8 _decimals,
    uint _INITIAL_SUPPLY) returns(address) {
    var token = address(new TestToken(_name, _symbol, _decimals, _INITIAL_SUPPLY, msg.sender));
    tokens[msg.sender].push(token);
    TokenCreated(msg.sender, token);
    return token;
    }
    
    function getTokens(address _owner) view public returns(address[]) {
        return tokens[_owner];
    }
}