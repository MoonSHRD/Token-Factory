pragma solidity ^0.4.24;

import "./Token.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";


contract Community is Ownable {
    using SafeMath for uint256;

    mapping(address => bool) members;
    uint256 rate;
    Token public token;

    bool public prepared;

    modifier onlyMember {
        require(members[msg.sender]);
        _;
    }

    constructor(uint256 _rate, address _owner) public {
        rate = _rate;
        owner = _owner;
    }
    
    function() external payable {
        buyTokens(msg.sender);
    }

    function setToken(Token _token) public {
        token = _token;
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


    function buyTokens(address _address) internal {
        uint256 weiAmount = msg.value;
        require(_address != address(0));
        require(weiAmount != 0);

        uint256 tokens = weiAmount.mul(rate);

        token.transfer(_address, tokens);
    }

    function beforeJoin() internal {}

    function afterJoin() internal {}

    function beforeLeave() internal {}

    function afterLeave() internal {}

}

