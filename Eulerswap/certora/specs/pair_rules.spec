/*
    This is a base specification file for the verification of the UniswapV2pair.sol
    smart contract using the Certora prover. For more information, visit: https://www.certora.com/
*/
import "pair_definitions.spec"
import "pair_methods.spec"


// balances should always be greater than or equal to reserves at the end of every call to UniswapV2Pair.
invariant balancesAreGreaterOrEqualToReserves()
		(getToken0Balance() >= getToken0Reserve()) && (getToken1Balance() >= getToken1Reserve())

//rule balancesAreEqualToReservesAfterDeFiOperation(method f)
//filtered{f -> isDeFiMethod(f)}
//{
//	env e;
//	calldataarg args;
//	f(e,args);
//	assert (getToken0BalanceUINT256() == getToken0ReserveUINT256()) && (getToken1BalanceUINT256() == getToken1ReserveUINT256());
//}

invariant distinctTokens()
    getToken0() != getToken1() 
    {
        preserved{
            require getToken0() !=0 && getToken1() !=0;
        }
    }

rule mintIncreaseK {
	requireInvariant balancesAreGreaterOrEqualToReserves();

	uint balance0Before = getToken0Balance();
	uint balance1Before = getToken1Balance();
	mathint KbalanceBefore = to_mathint(balance0Before)*to_mathint(balance1Before);
	
	env e;
	address toMint;
	requireValidUser(toMint);
	uint liquidity = mint(e,toMint);
	
	uint balance0After = getToken0Balance();
	uint balance1After = getToken1Balance();
	mathint KbalanceAfter = to_mathint(balance0After) * to_mathint(balance1After);

	assert KbalanceBefore<=KbalanceAfter;
}

rule burnDecreaseK {
	requireInvariant balancesAreGreaterOrEqualToReserves();

	uint balance0Before = getToken0Balance();
	uint balance1Before = getToken1Balance();
	mathint KbalanceBefore = to_mathint(balance0Before)*to_mathint(balance1Before);
	
	env e;
	address toBurn;
	requireValidUser(toBurn);
	uint amount0;
	uint amount1;
	amount0, amount1 = burn(e,toBurn);
	
	uint balance0After = getToken0Balance();
	uint balance1After = getToken1Balance();
	mathint KbalanceAfter = to_mathint(balance0After) * to_mathint(balance1After);

	assert KbalanceBefore>=KbalanceAfter;
}

rule swapIncreaseK {
	require (getToken0Balance() == getToken0Reserve()) && (getToken1Balance() == getToken1Reserve());
	//requireInvariant balancesAreGreaterOrEqualToReserves();
	uint balance0Before = getToken0Balance();
	uint balance1Before = getToken1Balance();
	mathint KbalanceBefore = to_mathint(balance0Before)*to_mathint(balance1Before);
	
	env e;
	address toSend;
	uint amount0Out;
	uint amount1Out;
	bytes data;
	swap(e,amount0Out,amount1Out,toSend,data);
	
	uint balance0After = getToken0Balance();
	uint balance1After = getToken1Balance();
	mathint KbalanceAfter = to_mathint(balance0After) * to_mathint(balance1After);

	assert KbalanceBefore<=KbalanceAfter;
}


