pragma solidity =0.5.16;

import 'C:/Users/blaie/Documents/GitHub/CustomerExamples/Eulerswap/v2-core/contracts/autoFinder_UniswapV2Pair.sol';
import '../../v2-core/contracts/interfaces/IERC20.sol';

contract UniswapV2PairHarness is UniswapV2Pair {
    constructor() public UniswapV2Pair() {}
    // Certora: replaced low-level call with an IERC20 transfer request which is easier
    // for the prover to handle
    function _safeTransfer(address token, address to, uint value) internal {assembly { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00070000, 1037618708487) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00070001, 3) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00071000, token) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00071001, to) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00071002, value) }
        bool success = IERC20(token).transfer(to, value);
        require(success, 'UniswapV2: TRANSFER_FAILED');
    }


   // CERTORA: added getters and auxilary computational functions
    /////////////////////////////////////////////////////////////

    function getToken0() public view returns (address)
    {assembly { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00100000, 1037618708496) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00100001, 0) }
        return token0;
    }

    function getToken1() public view returns (address)
    {assembly { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff000f0000, 1037618708495) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff000f0001, 0) }
        return token1;
    }

    function getLPToken() public view returns (address)
    {assembly { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff000b0000, 1037618708491) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff000b0001, 0) }
        return address(this);
    }

    function getFactory() public view returns (address)
    {assembly { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff000a0000, 1037618708490) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff000a0001, 0) }
        return factory;
    }

    function tokenBalanceOf(address token, address user) public view returns (uint256) {assembly { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff000c0000, 1037618708492) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff000c0001, 2) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff000c1000, token) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff000c1001, user) }
        return IERC20(token).balanceOf(user);
    }

    function getToken0Balance() public view returns (uint _balance0) {assembly { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00110000, 1037618708497) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00110001, 0) }
        _balance0 = tokenBalanceOf(token0,address(this));
    }

    function getToken1Balance() public view returns (uint _balance1) {assembly { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff000d0000, 1037618708493) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff000d0001, 0) }
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


