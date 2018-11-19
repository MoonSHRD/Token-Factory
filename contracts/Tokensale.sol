pragma solidity ^0.4.24;

/*
    template for crowdsale ovveride

*/
import "./Token.sol";


contract Tokensale is Ownable{


    uint256 rate;
    address beneficiarWallet;
    Token token;
    bool prepared;

    event TokensaleCreated(address _token, address _beneficiarWallet);

    constructor (uint256 _rate, address _wallet, Token _token) public {

        rate = _rate;
        beneficiarWallet = _wallet;
        owner = _wallet;
        token = _token;

        emit TokensaleCreated(_wallet, address(_token));
    }

}
