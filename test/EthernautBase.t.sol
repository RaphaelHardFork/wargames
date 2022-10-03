// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "ds-test/test.sol";
import "forge-std/Test.sol";

interface Level {
    function createInstance(address _player) external payable returns (address);

    function validateInstance(address payable _instance, address _player)
        external
        returns (bool);
}

interface IEthernautMain {
    function createLevelInstance(Level _level) external payable;

    function submitLevelInstance(address payable _instance) external;
}

interface Instance {
    function password() external returns (string memory);

    function authenticate(string memory passkey) external;
}

contract EthernautBase_test is Test {
    address public PLAYER = 0x35b6183B2FF0CD0F07efcad20Adc51BA9B8f148f;
    address public MAIN = 0xD991431D8b033ddCb84dAD257f4821E9d5b38C33;
    address public LEVEL1 = 0x4E73b858fD5D7A5fc1c3455061dE52a53F35d966;
    address public LEVEL1_I = 0xc09980175E6853dA4B8B722bd792aF7769BE2F84;

    IEthernautMain public ethernaut;

    function setUp() public {
        ethernaut = IEthernautMain(MAIN);
    }

    function testCreateInstance() public {
        vm.startPrank(PLAYER);

        ethernaut.createLevelInstance(Level(LEVEL1));

        ethernaut.submitLevelInstance(payable(LEVEL1_I));
    }
}
