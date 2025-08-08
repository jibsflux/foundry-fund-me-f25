//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "src/FundMe.sol";

contract FundFundMe is Script {
    address User = makeAddr("john");
    uint256 public constant SEND_VALUE = 0.1 ether;

    function fundingFundMe(address _mostrecentlyDepolyed) public {
        vm.prank(User);
        vm.deal(User, 1e18);
        FundMe(payable(_mostrecentlyDepolyed)).fund{value: SEND_VALUE}();
        console.log("Funded FundMe with %s", SEND_VALUE);
    }

    function run() external {
        address mostRecentlyDepolyed = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        vm.startBroadcast();
        fundingFundMe(mostRecentlyDepolyed);
        vm.stopBroadcast();
    }
}

contract WithdrawFundMe is Script {
    function withdrawFundMe(address _mostrecentlyDepolyed) public {
        vm.startBroadcast();
        FundMe(payable(_mostrecentlyDepolyed)).withdraw();
        vm.stopBroadcast();
    }

    function run() external {
        address mostRecentlyDepolyed = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        vm.startBroadcast();
        withdrawFundMe(mostRecentlyDepolyed);
        vm.stopBroadcast();
    }
}
