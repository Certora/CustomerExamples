/*
    This is a base specification file for the verification of the UniswapV2pair.sol
    smart contract using the Certora prover. For more information, visit: https://www.certora.com/
*/

import "methods.spec"

definition isDeFiMethod(method f) returns bool =
        f.selector == mint(address).selector || 
        f.selector == burn(address).selector ||
		f.selector == swap(uint256,uint256, address,bytes).selector;

definition isTokenTransfer(method f) returns bool =
        f.selector == token0.transfer(address,uint256).selector || 
		f.selector == token1.transfer(address,uint256).selector;

// balances should always be greater than or equal to reserves at the end of every call to UniswapV2Pair.
invariant balancesAreGreaterOrEqualToReserves()
		(getToken0BalanceUINT256() >= getToken0ReserveUINT256()) && (getToken1BalanceUINT256() >= getToken1ReserveUINT256())

rule balancesAreEqualToReservesAfterDeFiOperation(method f)
filtered{f -> isDeFiMethod(f)}
{
	env e;
	calldataarg args;
	f(e,args);
	assert (getToken0BalanceUINT256() == getToken0ReserveUINT256()) && (getToken1BalanceUINT256() == getToken1ReserveUINT256());
}

rule mintIncreaseK {
	requireInvariant balancesAreGreaterOrEqualToReserves();
	uint balance0Before;
	uint balance1Before;
	balance0Before , balance1Before = getBalancesUINT256();
	mathint KbalanceBefore = to_mathint(balance0Before)*to_mathint(balance1Before);
	
	env e;
	address toMint;
	requireValidUser(toMint);
	uint liquidity = mint(e,toMint);
	
	uint balance0After;
	uint balance1After;
	balance0After,balance1After = getBalancesUINT256();
	mathint KbalanceAfter = to_mathint(balance0After) * to_mathint(balance1After);
	assert KbalanceBefore<=KbalanceAfter;
}

rule burnDecreaseK {
	requireInvariant balancesAreGreaterOrEqualToReserves();
	uint balance0Before;
	uint balance1Before;
	balance0Before , balance1Before = getBalancesUINT256();
	mathint KbalanceBefore = to_mathint(balance0Before)*to_mathint(balance1Before);
	
	env e;
	address toBurn;
	requireValidUser(toBurn);
	uint amount0;
	uint amount1;
	amount0, amount1 = burn(e,toBurn);
	
	uint balance0After;
	uint balance1After;
	balance0After,balance1After = getBalancesUINT256();
	mathint KbalanceAfter = to_mathint(balance0After) * to_mathint(balance1After);
	assert KbalanceBefore>=KbalanceAfter;
}

rule swapIncreaseK {
	require (getToken0BalanceUINT256() == getToken0ReserveUINT256()) && (getToken1BalanceUINT256() == getToken1ReserveUINT256());
	//requireInvariant balancesAreGreaterOrEqualToReserves();
	uint balance0Before;
	uint balance1Before;
	balance0Before , balance1Before = getBalancesUINT256();
	mathint KbalanceBefore = to_mathint(balance0Before)*to_mathint(balance1Before);
	
	env e;
	address toSend;
	uint amount0Out;
	uint amount1Out;
	bytes data;
	swap(e,amount0Out,amount1Out,toSend,data);
	
	uint balance0After;
	uint balance1After;
	balance0After,balance1After = getBalancesUINT256();
	mathint KbalanceAfter = to_mathint(balance0After) * to_mathint(balance1After);
	assert KbalanceBefore<=KbalanceAfter;
}


function requireValidUser(address user)
	{
		require (user != 0) && (user != currentContract);
	}

