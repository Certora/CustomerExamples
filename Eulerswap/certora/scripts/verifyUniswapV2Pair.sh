#!/bin/sh

certoraRun \
    v2-core/contracts/UniswapV2PairHarness.sol:UniswapV2Pair \
    v2-core/contracts/UniswapV2Factory.sol:UniswapV2Factory \
    mocks/DummyERC20A.sol:DummyERC20A \
    mocks/DummyERC20B.sol:DummyERC20B \
--link UniswapV2Pair:factory=UniswapV2Factory UniswapV2Pair:token0=DummyERC20A UniswapV2Pair:token1=DummyERC20B \
--verify UniswapV2Pair:certora/specs/UniswapV2Pair.spec \
--rule BalancesAreGreaterOrEqualToReserves \
--solc solc5.16 \
--loop_iter 3 \
--optimistic_loop \
--disableLocalTypeChecking \
--msg "Uniswap v2 BalancesAreGreaterOrEqualToReserves $1" \

## --rule <rule name> for only 1 rule
## --method for only 1 method 