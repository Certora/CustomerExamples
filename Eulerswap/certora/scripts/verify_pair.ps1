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
certoraRun.exe $UniswapV2_Core_Harness_Path\UniswapV2PairHarness.sol:UniswapV2PairHarness $UniswapV2_Core_Harness_Path\UniswapV2FactoryHarness.sol:UniswapV2FactoryHarness $UniswapV2_ERC20_Harness_Path\DummyERC20A.sol:DummyERC20A $UniswapV2_ERC20_Harness_Path\DummyERC20B.sol:DummyERC20B `
--verify `
    UniswapV2PairHarness:$UniswapV2_Spec_Path\pair_rules.spec `
--link `
    UniswapV2PairHarness:factory=UniswapV2FactoryHarness UniswapV2PairHarness:token0=DummyERC20A UniswapV2PairHarness:token1=DummyERC20B `
--solc solc5.16 `
--loop_iter 3 `
--optimistic_loop `
--cloud `
--msg "Eulerswap PairTest" 