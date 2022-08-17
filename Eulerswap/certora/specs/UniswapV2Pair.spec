/*
    This is a base specification file for the verification of the UniswapV2pair.sol
    smart contract using the Certora prover. For more information, visit: https://www.certora.com/
*/

import "../../AuxilaryFunctions.spec"

using DummyERC20A as token0
using DummyERC20B as token1


	methods{
		////////////////////////////////////////
		// contract methods
		getReserves() returns (uint112, uint112, uint32) envfree

		swap(uint, uint, address, bytes) returns () 
		burn(address) returns (uint, uint) 
		mint(address) returns (uint) 
		skim(address) returns () envfree

		////////////////////////////////////////
		// ERC20 methods

		token0.balanceOf(address) envfree
		token0.totalSupply() envfree
		token0.transfer(address,uint256) 

		token1.balanceOf(address) envfree
		token1.totalSupply() envfree
		token1.transfer(address,uint256) 

		////////////////////////////////////////
		// CERTORA: getters and auxilary computational functions
		getBalancesUINT256() returns (uint,uint) envfree
        getToken0BalanceUINT256() returns (uint) envfree
        getToken1BalanceUINT256() returns (uint) envfree

		getReservesUINT256() returns (uint,uint) envfree
        getToken0ReserveUINT256() returns (uint) envfree
        getToken1ReserveUINT256() returns (uint) envfree
		////////////////////////////////////////
	}

	rule mintIncreaseK {
		requireInvariant BalancesAreGreaterOrEqualToReserves();
		uint balance0Before;
		uint balance1Before;
		uint reserve0Before;
		uint reserve1Before;
		balance0Before , balance1Before = getBalancesUINT256();
		reserve0Before , reserve1Before = getReservesUINT256();
		mathint KreserveBefore = MultiplyUINT256(reserve0Before,reserve1Before);
		env e;
		address toMint;
		requireValidUser(toMint);
		uint liquidity = mint(e,toMint);
		uint balance0After;
		uint balance1After;
		uint reserve0After;
		uint reserve1After;
		balance0After,balance1After = getBalancesUINT256();
		reserve0After,reserve1After = getReservesUINT256();
		mathint KreserveAfter = MultiplyUINT256(reserve0After,reserve1After);
		assert KreserveBefore<=KreserveAfter;
	}

	rule burnDecreaseK {
		requireInvariant BalancesAreGreaterOrEqualToReserves();
		uint balance0Before;
		uint balance1Before;
		uint reserve0Before;
		uint reserve1Before;
		balance0Before , balance1Before = getBalancesUINT256();
		reserve0Before , reserve1Before = getReservesUINT256();
		mathint KreserveBefore = MultiplyUINT256(reserve0Before,reserve1Before);
		env e;
		address toBurn;
		requireValidUser(toBurn);
		uint amount0;
		uint amount1;
		amount0, amount1 = burn(e,toBurn);
		uint balance0After;
		uint balance1After;
		uint reserve0After;
		uint reserve1After;
		balance0After,balance1After = getBalancesUINT256();
		reserve0After,reserve1After = getReservesUINT256();
		mathint KreserveAfter = MultiplyUINT256(reserve0After,reserve1After);
		assert KreserveBefore>=KreserveAfter;
	}


	// balances should always be greater than or equal to reserves at the end of every call to UniswapV2Pair.
	invariant BalancesAreGreaterOrEqualToReserves()
		(getToken0BalanceUINT256() >= getToken0ReserveUINT256()) &&
		(getToken1BalanceUINT256() >= getToken1ReserveUINT256())
