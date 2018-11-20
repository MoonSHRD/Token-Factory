pragma solidity ^0.4.25;

contract IterableMap {

    struct Entry {
        uint index;
        Deal value;
    }

    mapping(address => Entry) internal map;

    address[] internal keyList;

    function add(address _key, Deal _value) public {
        Entry storage entry = map[_key];
        entry.value = _value;
        if (entry.index > 0) {// entry exists
            // do nothing
            return;
        } else {// new entry
            keyList.push(_key);
            uint keyListIndex = keyList.length - 1;
            entry.index = keyListIndex + 1;
        }
    }

    function remove(address _key) public {
        Entry storage entry = map[_key];
        require(entry.index != 0);
        require(entry.index <= keyList.length);

        // Move an last element of array into the vacated key slot.
        uint keyListIndex = entry.index - 1;
        uint keyListLastIndex = keyList.length - 1;
        map[keyList[keyListLastIndex]].index = keyListIndex + 1;
        keyList[keyListIndex] = keyList[keyListLastIndex];
        keyList.length--;
        delete map[_key];
    }

    function size() public view returns (uint) {
        return uint(keyList.length);
    }

    function contains(address _key) public view returns (bool) {
        return map[_key].index > 0;
    }

    function getByKey(address _key) public view returns (Deal) {
        return map[_key].value;
    }

    function getByIndex(uint _index) public view returns (Deal) {
        require(_index >= 0);
        require(_index < keyList.length);
        return map[keyList[_index]].value;
    }

    function getKeys() public view returns (address[]) {
        return keyList;
    }

}
