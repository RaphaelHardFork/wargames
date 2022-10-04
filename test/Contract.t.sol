// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "ds-test/test.sol";
import "forge-std/Test.sol";

contract Storage {
    address public one;
    uint256 private two;
    mapping(address => uint256) private three;
    address[] private four;

    constructor() {
        one = address(3);
        two = 56;
        three[one] = two;
        four = new address[](5);
        four[0] = address(57);
        four[1] = address(23);
        four[2] = address(71);
    }
}

contract Contract_test is Test {
    Storage public _storage;

    function setUp() public {
        _storage = new Storage();
    }

    function testStorage() public {
        emit log_bytes32(vm.load(address(_storage), bytes32(uint256(0))));
        emit log_bytes32(vm.load(address(_storage), bytes32(uint256(1))));
        emit log_bytes32(vm.load(address(_storage), bytes32(uint256(3)))); // contains size of the array

        // Values of the array
        bytes32 position = keccak256(abi.encode(3));
        emit log_bytes32(vm.load(address(_storage), position));
        position = bytes32(uint256(position) + 1);
        emit log_bytes32(vm.load(address(_storage), position));
        position = bytes32(uint256(position) + 1);
        emit log_bytes32(vm.load(address(_storage), position));

        emit log_bytes32(vm.load(address(_storage), bytes32(uint256(2)))); // mapping = Empty slot

        address one = _storage.one();
        uint256 slot = uint256(2);
        bytes32 paddedAddr = bytes32(bytes20(one));

        emit log_bytes32(
            vm.load(
                address(_storage),
                keccak256(bytes.concat(paddedAddr, bytes32(slot)))
            )
        );
    }
}
