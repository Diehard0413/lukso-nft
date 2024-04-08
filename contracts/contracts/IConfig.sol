// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

interface IConfig {
    event AdminFeeUpdated(uint16 newAdminFee);
    
    event MaxBorrowDurationUpdated(uint256 newMaxBorrowDuration);
    
    event MinBorrowDurationUpdated(uint256 newMinBorrowDuration);
    
    event LSP7Permit(address indexed lsp7Contract, bool isPermitted);
    
    event LSP8Permit(address indexed lsp8Contract, bool isPermitted);
    
    event AdminFeeReceiverUpdated(address);
    
    function maxBorrowDuration() external view returns (uint256);
    
    function minBorrowDuration() external view returns (uint256);
    
    function adminShare() external view returns (uint16);
    
    function updateMaxBorrowDuration(uint256 _newMaxBorrowDuration)
        external;
    
    function updateMinBorrowDuration(uint256 _newMinBorrowDuration)
        external;
    
    function updateAdminShare(uint16 _newAdminShare) external;
    
    function updateAdminFeeReceiver(address _newAdminFeeReceiver) external;
    
    function getLSP7Permit(address _lsp7) external view returns (bool);
    
    function getLSP8Permit(address _lsp8) external view returns (bool);
    
    function setLSP7Permits(address[] memory _lsp7s, bool[] memory _permits)
        external;
    
    function setLSP8Permits(address[] memory _lsp8s, bool[] memory _permits)
        external;
}
