pragma solidity ^0.8.24;
import "../shared/models/VRF_Model.sol";
import "../shared/errors/Step1_Automation_errors.sol";
import "@openzeppelin/utils/Counters.sol";
import "@chainlink/src/v0.8/automation/AutomationCompatible.sol";
import "../shared/_upgradableContracts.sol";
// uint Id;
//     address client;
//     uint256 number;
//     uint256 vrfTime;
//     bool automationByLogStatus;
//     uint256 automationByLogTime;
//     bool functionStatus;
//     uint256 functionTime;
contract Step1_AutomationByTime is AutomationCompatibleInterface, UUPSUpgradeable, OwnableUpgradeable, AccessControlUpgradeable {
    address private _owner;
    uint256 private _startAutomationTime;
    Counters.Counter private _lastID;
    mapping(uint256 => bool) private _lastIdStatus;
    mapping(uint256 => VRF_Model) private _requests;
    constructor() {
        _owner = msg.sender;
        Counters.reset(_lastID);

        __Ownable_init();
        __AccessControl_init();
    }

    function modifyAutomationTime(uint256 startAutomationTime_) public onlyOwner {
        _startAutomationTime = startAutomationTime_;
    }

    function addNewNumber() public returns (uint256) {
        require(_lastIdStatus[_lastID._value], remainLastID());
        Counters.increment(_lastID);
        _requests[_lastID._value] = VRF_Model(_lastID._value, msg.sender, 0, 0, false, 0, false, 0);
        _lastIdStatus[_lastID._value] = false;
        return _lastID._value;
    }

    function checkUpkeep(bytes calldata checkData) external view override returns (bool upkeepNeeded, bytes memory performData) {
        if (_startAutomationTime > 0 && _startAutomationTime <= block.timestamp) {
            upkeepNeeded = true;
            performData = abi.encode(_lastIdStatus[_lastID._value]);
        }
        return (upkeepNeeded, performData);
    }
    function performUpkeep(bytes calldata performData) external override {
        VRF_Model memory vm = abi.decode(performData, (VRF_Model));
        vm.number = 123;
        _requests[_lastID._value] = vm;
    }

    function _authorizeUpgrade(address newImplementation) internal override {}
}
