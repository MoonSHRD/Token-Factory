pragma solidity ^0.4.25;

import "./Membership.sol";



//@todo Доделать набросок фабрики сделаок
//@body Саму сдулек должен формировать клиент (тк он должен быть в состоянии ее и без конта)


contract DealFactory {

    enum DealTypes{
        MEMBERSHIP,
        COMMERCIAL_ARTICLE
    }

    function createAndOffer(DealAceptor _dealAcceptor) public payable returns (Deal){
        _dealAcceptor.suggest(new Membership());
    }

}
