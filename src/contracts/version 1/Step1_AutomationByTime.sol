pragma solidity ^0.8.24;
import "../../shared/models/DiscountCampain.sol";
import "../../shared/errors/Step1_Automation_errors.sol";
import "@chainlink/src/v0.8/automation/AutomationCompatible.sol";
import "../../shared/_upgradableContracts.sol";
contract Step1_AutomationByTime is AutomationCompatibleInterface, UUPSUpgradeable, OwnableUpgradeable, AccessControlUpgradeable {
    DiscountCampain private _campain;
    constructor() {
        __Ownable_init();
        __AccessControl_init();
        _campain = DiscountCampain(1, 10, 0, 0, false);
    }
    function modifyCampain(DiscountCampain memory campain_) onlyOwner returns (bool) {
        _campain = campain_;
    }

    function checkUpkeep(bytes calldata checkData) external returns (bool upkeepNeeded, bytes memory performData) {
        if (block.timestamp > _campain.startTime && block.timestamp < _campain.endTime && _campain.isActive) {
            upkeepNeeded = true;
        }
    }
    function performUpkeep(bytes calldata performData) external {}
    function _authorizeUpgrade(address newImplementation) internal override {}
}
