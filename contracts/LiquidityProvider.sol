// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@uniswap/v3-periphery/contracts/interfaces/INonfungiblePositionManager.sol";
import "@uniswap/v3-periphery/contracts/libraries/TransferHelper.sol";

contract LiquidityProvider {
    INonfungiblePositionManager public immutable nonfungiblePositionManager;

    constructor(INonfungiblePositionManager _nonfungiblePositionManager) {
        nonfungiblePositionManager = _nonfungiblePositionManager;
    }

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint24 fee,
        uint256 amountA,
        uint256 amountB,
        uint256 amountAMin,
        uint256 amountBMin,
        int24 tickLower,
        int24 tickUpper,
        address recipient,
        uint256 deadline
    ) external returns (uint256 tokenId, uint128 liquidity, uint256 amount0, uint256 amount1) {
        TransferHelper.safeTransferFrom(tokenA, msg.sender, address(this), amountA);
        TransferHelper.safeTransferFrom(tokenB, msg.sender, address(this), amountB);

        TransferHelper.safeApprove(tokenA, address(nonfungiblePositionManager), amountA);
        TransferHelper.safeApprove(tokenB, address(nonfungiblePositionManager), amountB);

        INonfungiblePositionManager.MintParams memory params = INonfungiblePositionManager.MintParams({
            token0: tokenA < tokenB ? tokenA : tokenB,
            token1: tokenA < tokenB ? tokenB : tokenA,
            fee: fee,
            tickLower: tickLower,
            tickUpper: tickUpper,
            amount0Desired: tokenA < tokenB ? amountA : amountB,
            amount1Desired: tokenA < tokenB ? amountB : amountA,
            amount0Min: tokenA < tokenB ? amountAMin : amountBMin,
            amount1Min: tokenA < tokenB ? amountBMin : amountAMin,
            recipient: recipient,
            deadline: deadline
        });

        (tokenId, liquidity, amount0, amount1) = nonfungiblePositionManager.mint(params);

        if (amount0 < amountA) {
            TransferHelper.safeApprove(tokenA, address(nonfungiblePositionManager), 0);
            uint256 refund0 = amountA - amount0;
            TransferHelper.safeTransfer(tokenA, msg.sender, refund0);
        }
        if (amount1 < amountB) {
            TransferHelper.safeApprove(tokenB, address(nonfungiblePositionManager), 0);
            uint256 refund1 = amountB - amount1;
            TransferHelper.safeTransfer(tokenB, msg.sender, refund1);
        }
    }
}