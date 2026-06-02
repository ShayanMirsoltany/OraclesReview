// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;
import "forge-std/Script.sol";
import "@openzeppelin/proxy/ERC1967/ERC1967Proxy.sol";
contract DeployStep1 is Script {
    function run() public {
        vm.startBroadcast();
        // CLT_Token impl = new CLT_Token();
        // bytes memory data = abi.encodeCall(CLT_Token.initialize, ("Chainlinker", "CLK", 200_000_000 ether));
        // address proxy = address(new ERC1967Proxy(address(impl), data));
        // console.log("Token proxy : ", proxy);
        vm.stopBroadcast();
    }
}

// contract DeployStep1 is Script {
//     function run() public {
//         vm.startBroadcast();
//         address proxyAddr = 0x6411cB2c1fCAC3d1Dc44BC2b23A06Fe8b86e9ad4;
//         CLT_Token2 v2 = new CLT_Token2();
//         CLT_Token(proxyAddr).upgradeTo(address(v2));
//         vm.stopBroadcast();
//     }
// }
