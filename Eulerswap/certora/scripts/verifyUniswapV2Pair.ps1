## Note: we assume the ABSOLUTE path from which the script is run is "..\UniswapV2\"

## Defines RELATIVE path to the local cloned Uniswap V2 core repo
$UniswapV2_Core_Path = ".\v2-core\contracts" 

## Defines RELATIVE path to the Certora ERC20 mocks 
$UniswapV2_ERC20_Mock_Path = ".\mocks"

## Defines RELATIVE path to the local CVL specification file library
$UniswapV2_Spec_Path = ".\certora\specs" 

## Runs the Certora prover 
certoraRun.exe $UniswapV2_Core_Path\UniswapV2PairHarness.sol:UniswapV2Pair $UniswapV2_Core_Path\UniswapV2Factory.sol:UniswapV2Factory $UniswapV2_ERC20_Mock_Path\DummyERC20A.sol:DummyERC20A $UniswapV2_ERC20_Mock_Path\DummyERC20B.sol:DummyERC20B `
--verify `
    UniswapV2Pair:$UniswapV2_Spec_Path\UniswapV2Pair.spec `
--rule `
BalancesAreGreaterOrEqualToReserves `
--link `
    UniswapV2Pair:factory=UniswapV2Factory UniswapV2Pair:token0=DummyERC20A UniswapV2Pair:token1=DummyERC20B `
--solc solc5.16 `
--staging `
--loop_iter 3 `
--optimistic_loop `
--disableLocalTypeChecking `
--msg "Uniswap v2 BalancesAreGreaterOrEqualToReserves" 