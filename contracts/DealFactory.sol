pragma solidity ^0.4.24;

import "./Membership.sol";
import "./DealAceptor.sol";



//@todo Доделать набросок фабрики сделаок
//@body Саму сдeлку должен формировать клиент (тк он должен быть в состоянии ее и без конта)


contract DealFactory {

    enum DealTypes{
        MEMBERSHIP,
        COMMERCIAL_ARTICLE
    }

    function createAndOffer(DealAceptor _dealAcceptor) public payable returns (Deal){
        _dealAcceptor.suggest(new Membership());
    }

}
