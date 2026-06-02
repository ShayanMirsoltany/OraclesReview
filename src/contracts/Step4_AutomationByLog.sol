pragma solidity ^0.8.24;
import "../shared/errors/Step1_Automation_errors.sol";
import "@openzeppelin/utils/Counters.sol";
import "@chainlink/src/v0.8/automation/AutomationCompatible.sol";
import "../shared/_upgradableContracts.sol";

contract Step4_AutomationByLog is AutomationCompatibleInterface, UUPSUpgradeable, OwnableUpgradeable, AccessControlUpgradeable {
    constructor() {
        __Ownable_init();
        __AccessControl_init();
    }

    function checkUpkeep(bytes calldata checkData) external returns (bool upkeepNeeded, bytes memory performData) {}

    function performUpkeep(bytes calldata performData) external {}

    function _authorizeUpgrade(address newImplementation) internal override {}
}
