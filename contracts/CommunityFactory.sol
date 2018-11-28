pragma solidity ^0.4.24;


import "./TokenFactory.sol";
import "./Token.sol";
import "./Community.sol";


contract CommunityFactory {

    TokenFactory factory;

    mapping (address => address[]) public communitys;
    mapping (address => address[]) public tokens;

    event CommunityTokenCreated(address _owner, address _token);
    event CommunityNoTokenCreated(address _owner, address _token);

    constructor (TokenFactory _factory) public {

        factory = _factory;

    }

        /**
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
    function createCommunityToken (string _name,
    string _symbol, uint8 _decimals,
    uint _INITIAL_SUPPLY, uint256 _rate, address _wallet) public returns(address){
            
        bool withToken = true;
        Community community = new Community(_wallet, withToken);
        community.setRate(_rate);
        address cdr = address(community);
        Token token = factory.createToken(_name,_symbol,_decimals,_INITIAL_SUPPLY, cdr);
        tokens[msg.sender].push(token);
        community.setToken(token);

        communitys[msg.sender].push(community);  
        emit CommunityTokenCreated(msg.sender, cdr);
        return cdr;
    }

    /**
    @notice createCommunity создает комьнити без токена, функция public, свободна для вызова
    @dev функция добавляет адрес комьюнити в мапинг communitys
    @param _wallet адрес владельца комьюнити
    @return {
    "cdr": "адрес созданного комьюнити",
    }
    */
    function createCommunity (address _wallet) public returns(address) {
        bool withToken = false;
        Community community = new Community(_wallet, withToken);
        communitys[msg.sender].push(community);
        address cdr = address(community);
        emit CommunityNoTokenCreated(msg.sender, address(cdr));
        return cdr;
    }

    function hasCommunitys(address _owner) public view returns (bool) {
        return communitys[_owner].length > 0;
    }

    function getCommunitys(address _owner) public view returns(address[]) {
        return communitys[_owner];
    }

    function hasTokens(address _owner) view public returns (bool){
        return tokens[_owner].length > 0;
    }

    function getTokens(address _owner) view public returns(address[]) {
        return tokens[_owner];
    }


}


