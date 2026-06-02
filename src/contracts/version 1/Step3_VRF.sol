pragma solidity ^0.8.24;
import "../../shared/_upgradableContracts.sol";
contract Step3_VRF is UUPSUpgradeable, OwnableUpgradeable, AccessControlUpgradeable {
    constructor() {
        __Ownable_init();
        __AccessControl_init();
    }
    function _authorizeUpgrade(address newImplementation) internal override {}
}
