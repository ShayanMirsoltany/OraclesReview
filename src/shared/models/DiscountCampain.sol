pragma solidity ^0.8.24;
struct DiscountCampain {
    uint256 id;
    uint8 discountPercent;
    uint256 startTime;
    uint256 endTime;
    bool isActive;
}
