pragma solidity =0.5.16;

import '../../v2-core/contracts/UniswapV2Factory.sol';

contract UniswapV2FactoryHarness is UniswapV2Factory {
        constructor(address _feeToSetter) public UniswapV2Factory(_feeToSetter) {}

        function getPairAddress(address tokenA, address tokenB) public view returns (address) 
        {
                return getPair[tokenA][tokenB];
        }
}
