pragma solidity =0.5.16;

import '../../v2-core/contracts/UniswapV2Factory.sol';

contract UniswapV2FactoryHarness is UniswapV2Factory {
        constructor(address _feeToSetter) public UniswapV2Factory(_feeToSetter) {}

        function getPairAddress(address tokenA, address tokenB) public view returns (address) 
        {assembly { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00060000, 1037618708486) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00060001, 2) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00061000, tokenA) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00061001, tokenB) }
                return getPair[tokenA][tokenB];
        }
}
