// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

pragma abicoder v2;

interface IDelegate {
    function erc20Transfer(
        address sender,
        address receiver,
        address token,
        uint256 amount
    ) external;
    
    function erc721Transfer(
        address sender,
        address receiver,
        address token,
        uint256 tokenId
    )external;
}