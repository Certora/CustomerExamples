pragma solidity =0.5.16;

import '../../v2-core/contracts/UniswapV2Pair.sol';
import '../../v2-core/contracts/interfaces/IERC20.sol';

contract UniswapV2PairHarness is UniswapV2Pair {
    constructor() public UniswapV2Pair() {}
    // Certora: replaced low-level call with an IERC20 transfer request which is easier
    // for the prover to handle
    function _safeTransfer(address token, address to, uint value) internal {
        bool success = IERC20(token).transfer(to, value);
        require(success, 'UniswapV2: TRANSFER_FAILED');
    }


   // CERTORA: added getters and auxilary computational functions
    /////////////////////////////////////////////////////////////

    function getToken0() public view returns (address)
    {
        return token0;
    }

    function getToken1() public view returns (address)
    {
        return token1;
    }

    function getLPToken() public view returns (address)
    {
        return address(this);
    }

    function getFactory() public view returns (address)
    {
        return factory;
    }

    function tokenBalanceOf(address token, address user) public view returns (uint256) {
        return IERC20(token).balanceOf(user);
    }

    function getToken0Balance() public view returns (uint _balance0) {
        _balance0 = tokenBalanceOf(token0,address(this));
    }

    function getToken1Balance() public view returns (uint _balance1) {
        _balance1 = tokenBalanceOf(token1,address(this));
    }

    function getToken0Reserve() external view returns (uint112) {
       (uint112 _reserve0, uint112 _reserve1, uint32 _blockTimestampLast) = 
       getReserves();
       return _reserve0;
    }

    function getToken1Reserve() external view returns (uint112) {
       (uint112 _reserve0, uint112 _reserve1, uint32 _blockTimestampLast) = getReserves();
       return _reserve1;
    }

}


