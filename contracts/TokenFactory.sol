pragma solidity ^0.4.24;


import "./Token.sol";
import "./Tokensale.sol";
import "./ITokenObserver.sol";


contract TokenFactory {


    address god;
    mapping (address => address[]) public tokens;
    ITokenObserver[] public observers;

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

    function addObserver(address _observer) public onlyGod {
        observers.push(ITokenObserver(_observer));
    }




// Function that create Token, tokensale contract and start it at once
// Note that it can be burn a lot of gas, so I think we need to split this function in the future
     function createTokensaleToken(string _name,
     string _symbol, uint8 _decimals,
     uint _INITIAL_SUPPLY, uint256 _rate, address _wallet) public returns(address){
       Token token = createToken(_name,_symbol,_decimals,_INITIAL_SUPPLY);
       address crd = createTokensale(_rate,_wallet,token);
       token.prepareCrowdsale(crd);
         return crd;
   }

// Function that creates tokensale with given parameters
    function createTokensale(uint256 _rate, address _wallet, Token _token) public returns(address) {
        address tokensale = address(new Tokensale(_rate,_wallet,_token));

        return tokensale;
    }


// function that create Simple Token without tokensale
// Returns Token object with new address
    function createToken(string _name,
    string _symbol,
    uint8 _decimals,
    uint _INITIAL_SUPPLY) public returns(Token) {
  //  address token = 0x0;
      Token token = new Token(_name, _symbol, _decimals, _INITIAL_SUPPLY, msg.sender);

        tokens[msg.sender].push(token);
        emit TokenCreated(msg.sender, address(token));

       return token;

    }

    function hasTokens(address _owner) view public returns (bool){
        return tokens[_owner].length >0;
    }

    function getTokens(address _owner) view public returns(address[]) {
            return tokens[_owner];
    }
}
