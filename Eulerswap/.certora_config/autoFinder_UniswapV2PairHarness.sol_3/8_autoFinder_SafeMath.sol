pragma solidity =0.5.16;

// a library for performing overflow-safe math, courtesy of DappHub (https://github.com/dapphub/ds-math)

library SafeMath {
    function add(uint x, uint y) internal pure returns (uint z) {assembly { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff001b0000, 1037618708507) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff001b0001, 2) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff001b1000, x) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff001b1001, y) }
        require((z = x + y) >= x, 'ds-math-add-overflow');
    }

    function sub(uint x, uint y) internal pure returns (uint z) {assembly { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff001c0000, 1037618708508) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff001c0001, 2) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff001c1000, x) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff001c1001, y) }
        require((z = x - y) <= x, 'ds-math-sub-underflow');
    }

    function mul(uint x, uint y) internal pure returns (uint z) {assembly { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff001d0000, 1037618708509) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff001d0001, 2) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff001d1000, x) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff001d1001, y) }
        require(y == 0 || (z = x * y) / y == x, 'ds-math-mul-overflow');
    }
}
