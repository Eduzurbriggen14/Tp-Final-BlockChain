//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {CCNFT} from "../src/CCNFT.sol";
import "lib/forge-std";

contract DeployCCNFT is Script{

    function run () public returns (CCNFT){

        vm.startBroadcast();

        CCNFT ccnft = new CCNFT("token", "tk");

        vm.stopBroadcast();
        return ccnft;
    }

}
