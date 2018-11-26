pragma solidity ^0.4.24;

import "./Token.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";


contract Community is Ownable {
    using SafeMath for uint256;

    mapping(address => bool) members;
    
    uint256 rate;
    
    Token public token;

    bool public prepared = false;
    bool public withToken;

    event CommunityWasPrepared(address _community, address _owner);

    modifier onlyMember {
        require(members[msg.sender]);
        _;
    }

    constructor(address _owner, bool _withToken) public {
        owner = _owner;
        withToken = _withToken;
    }
    
    function() external payable {
        buyTokens(msg.sender, msg.value);
    }

    function setToken(Token _token) public {
        require(withToken == true && address(token) == address(0), "this community must have no token");
        token = _token;
    }
        /**
    @notice setRate вызывется при создании комьюнити вместе стокеном
    @dev функция вызывает один раз и последующие попытки приведут к реверту
    */
    function setRate(uint256 _rate) public {
        require(prepared == false && withToken == true, "rate was set");
        rate = _rate;
    }
        /**
    @notice prepareCommunity делает возможным продажу токенов комьюнити
    @dev функция вызывает метод токена для передачи токенов на адрес комьюнити, вызвается только владельцем комьюнити и только один раз
    */
    function prepareCommunity() external onlyOwner {
        require(withToken == true, "this community have no token");
        require(prepared == false, "Community was prepared");
        token.transferToCommunity();
        prepared = true;

        emit CommunityWasPrepared(address(this), owner);
    }

    function join() public {
        require(!members[msg.sender]);
        beforeJoin();
        members[msg.sender] = true;
        afterJoin();
    }

    function leave() public {
        require(members[msg.sender]);
        beforeLeave();
        members[msg.sender] = false;
        afterLeave();
    }

        /**
    @notice buyTokens фнкция по умолчанию для покупки токенов комьюнити
    @dev вызвать функцию можно отправив эфир на адрес комьюнити
    */
    function buyTokens(address _to, uint256 _weiAmount) internal {
        require(_to != address(0), "address _to is null");
        require(_weiAmount != 0, "weiAmount is null");

        uint256 tokens = _weiAmount.mul(rate);
        token.transfer(_to, tokens);
    }

    function beforeJoin() internal {}

    function afterJoin() internal {}

    function beforeLeave() internal {}

    function afterLeave() internal {}

}

