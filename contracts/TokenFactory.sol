pragma solidity ^0.4.24;


import "./Token.sol";
import "zeppelin-solidity/contracts/crowdsale/Crowdsale.sol";


contract TokenFactory {
    address god;
    mapping (address => address[]) public tokens;
    // define zheton as Token contract. There is might be a pitfall, cause crowdsale await ERC20
  //  Token public zheton;

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






// Function that create Token, crowdsale contract and start it at once
// Note that it can be burn a lot of gas, so I think we need to split this function in the future
     function createCrowdsaleToken(string _name,
     string _symbol,
     uint _INITIAL_SUPPLY, uint256 _rate, address _wallet) public{
    //   Token tok = createToken(_name,_symbol,_INITIAL_SUPPLY);
       Token tok = Token(new Token(_name, _symbol, _INITIAL_SUPPLY, msg.sender));
       address crd = createCrowdsale(_rate,_wallet,tok);




   }

// Function that creates crowdsale with given parameters
    function createCrowdsale(uint256 _rate, address _wallet, Token _token) public returns(address) {
      address crowdsale = 0x0;
      crowdsale = address(new Crowdsale(_rate,_wallet,_token));
      return crowdsale;


    }


// function that create Simple Token without crowdsale
//  this functiuon returns ADDRESS type
    function createToken(string _name,
    string _symbol,

    uint _INITIAL_SUPPLY) public returns(address) {
  //  address token = 0x0;
      address token = address(new Token(_name, _symbol, _INITIAL_SUPPLY, msg.sender));

        tokens[msg.sender].push(token);
        emit TokenCreated(msg.sender, token);
       return token;

    }


    function getTokens(address _owner) view public returns(address[]) {
        return tokens[_owner];
    }
}
