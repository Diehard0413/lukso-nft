// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/introspection/IERC165.sol";
import "./IConfig.sol";

abstract contract Config is
    AccessControl,
    IConfig
{
    
    bytes32 public constant MANAGER_ROLE = keccak256("MANAGER");
    
    bytes32 public constant SIGNER_ROLE = keccak256("SIGNER");
    
    address public adminFeeReceiver;
    
    uint256 public override maxBorrowDuration = 365 days;
    uint256 public override minBorrowDuration = 1 days;
    
    uint16 public override adminShare = 25;
    uint16 public constant HUNDRED_PERCENT = 10000;
    
    mapping(address => bool) private lsp7Permits; 
    mapping(address => bool) private lsp8Permits;
    
    constructor(address admin) {
        _grantRole(DEFAULT_ADMIN_ROLE, admin);
        adminFeeReceiver = admin;
    }
    
    function updateMaxBorrowDuration(uint256 _newMaxBorrowDuration)
        external
        override
        onlyRole(MANAGER_ROLE)
    {
        require(
            _newMaxBorrowDuration >= minBorrowDuration,
            "Invalid duration"
        );
        if(maxBorrowDuration != _newMaxBorrowDuration) {
            maxBorrowDuration = _newMaxBorrowDuration;
            emit MaxBorrowDurationUpdated(_newMaxBorrowDuration);
        }
    }
    
    function updateMinBorrowDuration(uint256 _newMinBorrowDuration)
        external
        override
        onlyRole(MANAGER_ROLE)
    {
        require(
            _newMinBorrowDuration <= maxBorrowDuration,
            "Invalid duration"
        );
        if(minBorrowDuration != _newMinBorrowDuration) {
            minBorrowDuration = _newMinBorrowDuration;
            emit MinBorrowDurationUpdated(_newMinBorrowDuration);
        }
    }
    
    function updateAdminShare(uint16 _newAdminShare)
        external
        override
        onlyRole(MANAGER_ROLE)
    {
        require(
            _newAdminShare <= HUNDRED_PERCENT,
            "basis points > 10000"
        );
        if(adminShare != _newAdminShare) {
            adminShare = _newAdminShare;
            emit AdminFeeUpdated(_newAdminShare);
        }
    }
    
    function updateAdminFeeReceiver(address _newAdminFeeReceiver)
        external
        override
        onlyRole(MANAGER_ROLE)
    {
        require(_newAdminFeeReceiver != address(0), "Invalid receiver address");
        if(adminFeeReceiver != _newAdminFeeReceiver) {
            adminFeeReceiver = _newAdminFeeReceiver;
            emit AdminFeeReceiverUpdated(adminFeeReceiver);
        }
    }
    
    function setLSP7Permits(address[] memory _lsp7s, bool[] memory _permits)
        external
        override
        onlyRole(MANAGER_ROLE)
    {
        require(
            _lsp7s.length == _permits.length,
            "address and permits length mismatch"
        );

        for (uint256 i = 0; i < _lsp7s.length; i++) {
            _setLSP7Permit(_lsp7s[i], _permits[i]);
        }
    }
    
    function setLSP8Permits(address[] memory _lsp8s, bool[] memory _permits)
        external
        override
        onlyRole(MANAGER_ROLE)
    {
        require(
            _lsp8s.length == _permits.length,
            "address and permits length mismatch"
        );

        for (uint256 i = 0; i < _lsp8s.length; i++) {
            _setLSP8Permit(_lsp8s[i], _permits[i]);
        }
    }
    
    function getLSP7Permit(address _lsp7)
        public
        view
        override
        returns (bool)
    {
        return lsp7Permits[_lsp7];
    } 
    
    function getLSP8Permit(address _lsp8)
        public
        view
        override
        returns (bool)
    {
        return lsp8Permits[_lsp8];
    }
   
    function _setLSP7Permit(address _lsp7, bool _permit) internal {
        require(_lsp7 != address(0), "lsp8 is zero address");

        lsp7Permits[_lsp7] = _permit;

        emit LSP7Permit(_lsp7, _permit);
    }
    
    function _setLSP8Permit(address _lsp8, bool _permit) internal {
        require(_lsp8 != address(0), "lsp8 is zero address");

        lsp8Permits[_lsp8] = _permit;

        emit LSP8Permit(_lsp8, _permit);
    }
}
