pragma solidity ^0.4.24;


import "./Token.sol";
import "./Tokensale.sol";
import "./Community.sol";


contract TokenFactory {


    address god;
    mapping (address => address[]) public tokens;
    mapping (address => address[]) public communitys;


    event TokenCreated(address _owner, address _token);
    event CommunityCreated(address _owner, address _token);

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


// Function that create Community with Token
// Note that it can be burn a lot of gas, so I think we need to split this function in the future
     function createCommunityToken(string _name,
     string _symbol, uint8 _decimals,
     uint _INITIAL_SUPPLY, uint256 _rate, address _wallet) public returns(address){
       Token token = createToken(_name,_symbol,_decimals,_INITIAL_SUPPLY);
       Community community = new Community(_rate,_wallet);
       community.setToken(token);
       address cdr = address(community);
       communitys[msg.sender].push(community);  
       token.prepareCommunity(cdr);
         return cdr;
   }

// Function that creates Community without token with given parameters
    function createCommunity(uint256 _rate, address _wallet) public returns(address) {
        Community community = new Community(_rate,_wallet);
        communitys[msg.sender].push(community);
        address cdr = address(community);
        emit CommunityCreated(msg.sender, cdr);
        return cdr;
    }


// function that create Simple Token without Community
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
        return tokens[_owner].length > 0;
    }

    function getTokens(address _owner) view public returns(address[]) {
            return tokens[_owner];
    }

    function hasCommunitys(address _owner) public view returns (bool) {
        return communitys[_owner].length > 0;
    }

    function getCommunitys(address _owner) public view returns(address[]) {
        return communitys[_owner];
    }
}
