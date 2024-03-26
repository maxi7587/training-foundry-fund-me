// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract FundFundMe is Script {
    uint256 constant SEND_VALUE = 0.01 ether;

    function run() external {
        // run on most recently deployed contract
        address contractAddress = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        fundFundMe(contractAddress);
    }

    function fundFundMe(address contractAddress) public {
        vm.startBroadcast();
        FundMe(payable(contractAddress)).fund{value: SEND_VALUE}();
        vm.stopBroadcast();
    }
}

contract WithdrawFundMe is Script {
    function run() external {
        // run on most recently deployed contract
        address contractAddress = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        withdrawFundMe(contractAddress);
    }

    function withdrawFundMe(address contractAddress) public {
        vm.startBroadcast();
        FundMe(payable(contractAddress)).withdraw();
        vm.stopBroadcast();
    }
}