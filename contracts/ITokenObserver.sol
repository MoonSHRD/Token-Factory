pragma solidity ^0.4.0;


contract ITokenObserver {

    function onTokenSaleCreated(address _tokenSale, address _tokenSaleOwner) returns (bool);

}
