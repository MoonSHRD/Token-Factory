pragma solidity ^0.4.24;

import "./Token.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";


contract Community is Ownable {

    mapping(address => bool) members;

    Token public token;

    bool public prepared;

    modifier onlyMember {
        require(members[msg.sender]);
        _;
    }

    constructor(uint256 _rate, address _owner, Token _token) public {
        rate = _rate;
        owner = _owner;
        token = _token;
        emit CommunityCreated(_wallet, address(_token));
    }


    function beforeJoin() internal {}

    function afterJoin() internal {}

    function beforeLeave() internal {}

    function afterLeave() internal {}


    function join() public {

        require(!users[msg.sender]);
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


    function buyTokens(address _address) public payable {
        uint256 weiAmount = msg.value;
        require(_address != address(0));
        require(_weiAmount != 0);

        uint256 tokens = _weiAmount.mul(rate);

        token.Transfer(_address, _tokens);
        emit EtherDeposited(msg.sender, msg.value);
    }

    function() external payable {
        buyTokens(msg.sender);
    }
}

