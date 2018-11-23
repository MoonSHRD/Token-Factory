pragma solidity ^0.4.24;


import "./Token.sol";
import "./Tokensale.sol";
import "./Community.sol";


contract TokenFactory {


    address god;
    mapping (address => address[]) public tokens;
    mapping (address => address[]) public communitys;


    event CommunityTokenCreated(address _owner, address _token);
    event CommunityNoTokenCreated(address _owner, address _token);
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


    /*
    @notice createCommunityToken создает комьнити с токеном, функция public, свободна для вызова
    @dev для создания токена используется createToken, владельцем токена назначается комьюнити, функция добавляет адрес комьюнити в мапинг communitys
    @param _name имя токена
    @param _symbol символ токена
    @param _decimals decimal токена
    @param _INITIAL_SUPPLY supply токена
    @param _rate rate для продажи токена
    @param _wallet адрес владельца комьюнити
    @return {
    "cdr": "адрес созданного комьюнити",
    }
    */
     function createCommunityToken(string _name,
     string _symbol, uint8 _decimals,
     uint _INITIAL_SUPPLY, uint256 _rate, address _wallet) public returns(address){
            
       bool withToken = true;
       Community community = new Community(_wallet, withToken);
       community.setRate(_rate);
       address cdr = address(community);
       Token token = createToken(_name,_symbol,_decimals,_INITIAL_SUPPLY, cdr);
       community.setToken(token);

       communitys[msg.sender].push(community);  
       emit CommunityTokenCreated(msg.sender, cdr);
         return cdr;
   }

    /*
    @notice createCommunity создает комьнити без токена, функция public, свободна для вызова
    @dev функция добавляет адрес комьюнити в мапинг communitys
    @param _wallet адрес владельца комьюнити
    @return {
    "cdr": "адрес созданного комьюнити",
    }
    */
    function createCommunity(address _wallet) public returns(address) {
        bool withToken = false;
        Community community = new Community(_wallet, withToken);
        communitys[msg.sender].push(community);
        address cdr = address(community);
        emit CommunityNoTokenCreated(msg.sender, address(cdr));
        return cdr;
    }


// function that create Simple Token without Community
// Returns Token object with new address
    function createToken(string _name,
    string _symbol,
    uint8 _decimals,
    uint _INITIAL_SUPPLY, address _owner) private returns(Token) {
  //  address token = 0x0;
      Token token = new Token(_name, _symbol, _decimals, _INITIAL_SUPPLY, _owner);

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
