pragma solidity ^0.4.24;

/*
    template for crowdsale ovveride

*/
import "./Token.sol";


contract Tokensale {


    uint256 rate;
    address beneficiarWallet;
    Token token;

    event TokenCreated(address _token, address _beneficiarWallet);

    constructor (uint256 _rate, address _wallet, Token _token) public {

        rate = _rate;
        beneficiarWallet = _wallet;
        token = _token;

        emit TokenCreated(_wallet, address(_token));
    }

}
