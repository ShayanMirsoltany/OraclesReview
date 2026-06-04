pragma solidity ^0.8.24;
import "../../shared/models/DiscountCampain.sol";
import "../../shared/errors/Step1_Automation_errors.sol";
import "@chainlink/src/v0.8/automation/AutomationCompatible.sol";
import "../../shared/_upgradableContracts.sol";
import "@openzeppelin/utils/Counters.sol";
contract Step1_AutomationByTime is AutomationCompatibleInterface, UUPSUpgradeable, OwnableUpgradeable, AccessControlUpgradeable {
    DiscountCampain private _campain;
    Counters.Counter private _count;
    event CountEvent(uint);

    function initialize() public initializer {
        __Ownable_init();
        __AccessControl_init();
        _campain = DiscountCampain(1, 10, 0, 0, false);
        _count = Counters.Counter(0);
    }

    function modifyCampain(DiscountCampain memory campain_) public onlyOwner returns (bool) {
        _campain = campain_;
        return true;
    }

    function modifyCampain2() public onlyOwner returns (bool) {
        _campain.isActive = true;
        _campain.startTime = block.timestamp;
        _campain.endTime = block.timestamp + 1000000;
        return true;
    }

    function checkUpkeep(bytes calldata checkData) external view override returns (bool upkeepNeeded, bytes memory performData) {
        if (block.timestamp > _campain.startTime && block.timestamp < _campain.endTime && _campain.isActive) {
            upkeepNeeded = true;
        }
    }

    function performUpkeep(bytes calldata performData) external override {
        Counters.increment(_count);
        emit CountEvent(_count._value);
    }

    function _authorizeUpgrade(address newImplementation) internal override {}
}

// cast code 0xe3645FE1eA808812426e011677F297BE67C10A44 --rpc-url $env:RPC_SEPOLIA
// cast call 0xe3645FE1eA808812426e011677F297BE67C10A44 "checkUpkeep(bytes)(bool,bytes)" 0x --rpc-url $env:RPC_SEPOLIA
// cast call 0xe3645FE1eA808812426e011677F297BE67C10A44 "owner()(address)" --rpc-url $env:RPC_SEPOLIA
