## Note: we assume the ABSOLUTE path from which the script is run is "..\Eulerswap\"

## Defines RELATIVE path to the local cloned Uniswap V2 Core repo
$UniswapV2_Core_Path = ".\v2-core\contracts" 

## Defines RELATIVE path to the local cloned Uniswap V2 Router repo
$UniswapV2_Periphery_Path = ".\v2-periphery\contracts" 

## Defines RELATIVE path to the Certora Core harness contracts 
$UniswapV2_Core_Harness_Path = ".\certora\harness"

## Defines RELATIVE path to the Certora ERC20 harness contracts 
$UniswapV2_ERC20_Harness_Path = ".\certora\harness"

## Defines RELATIVE path to the local CVL specification file library
$UniswapV2_Spec_Path = ".\certora\specs" 

## Runs the Certora prover 
certoraRun.exe $UniswapV2_Core_Harness_Path\UniswapV2PairHarness.sol:UniswapV2Pair $UniswapV2_Core_Harness_Path\UniswapV2FactoryHarness.sol:UniswapV2Factory $UniswapV2_ERC20_Harness_Path\DummyERC20A.sol:DummyERC20A $UniswapV2_ERC20_Harness_Path\DummyERC20B.sol:DummyERC20B `
--verify `
    UniswapV2Pair:$UniswapV2_Spec_Path\UniswapV2Pair.spec `
--link `
    UniswapV2Pair:factory=UniswapV2Factory UniswapV2Pair:token0=DummyERC20A UniswapV2Pair:token1=DummyERC20B `
--solc solc5.16 `
--rule swapIncreaseK `
--staging `
--loop_iter 3 `
--optimistic_loop `
--msg "Eulerswap swapIncreaseK" 