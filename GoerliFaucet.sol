// SPDX-License-Identifier: unlicense
pragma solidity ^0.8.4;

import "@uniswap/v3-periphery/contracts/interfaces/INonfungiblePositionManager.sol";
import "@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract UniswapV3FeesCollector is Ownable {
    INonfungiblePositionManager public positionManager;
    ISwapRouter public swapRouter;
    IERC20 public token0;
    IERC20 public token1;
    IERC20 public WETH;

    uint256 public lastCollectBlock;
    uint256 public lastClaimedBlock;

    mapping(address => uint256) public lastClaimedBy;

    constructor(
        address _positionManager,
        address _swapRouter,
        address _token0,
        address _token1,
        address _WETH
    ) {
        positionManager = INonfungiblePositionManager(_positionManager);
        swapRouter = ISwapRouter(_swapRouter);
        token0 = IERC20(_token0);
        token1 = IERC20(_token1);
        WETH = IERC20(_WETH);
    }

    function collectFees(uint256 tokenId) external onlyOwner {
        // Collect fees every 150000 blocks
        require(block.number >= lastCollectBlock + 150000, "Too early to collect");

        INonfungiblePositionManager.CollectParams memory params =
            INonfungiblePositionManager.CollectParams({
                tokenId: tokenId,
                recipient: address(this),
                amount0Max: type(uint128).max,
                amount1Max: type(uint128).max
            });

        // Collect fees
        positionManager.collect(params);

        // Update the last collected block
        lastCollectBlock = block.number;
    }

    function convertToWETH(uint256 amountIn, address token) internal {
        // Assuming token is either token0 or token1
        ISwapRouter.ExactInputSingleParams memory params =
            ISwapRouter.ExactInputSingleParams({
                tokenIn: token,
                tokenOut: address(WETH),
                fee: 3000, // Pool fee, in this case assuming 0.3%
                recipient: address(this),
                deadline: block.timestamp + 15, // Deadline of 15 seconds from now
                amountIn: amountIn,
                amountOutMinimum: 0,
                sqrtPriceLimitX96: 0
            });

        // Swap token for WETH
        swapRouter.exactInputSingle(params);
    }

    function distributeFaucet(uint256 amount) external {
        // Distribute every 15000000 blocks
        require(block.number >= lastClaimedBlock + 15000000, "Too early to claim");
        require(
            block.number >= lastClaimedBy[msg.sender] + 15000000,
            "Address has already claimed"
        );

        // Transfer WETH to the caller
        WETH.transfer(msg.sender, amount
