import "factory_methods.spec"
////////////////////////////////////////////////////////////////////////////
//                       Rules                                            //
////////////////////////////////////////////////////////////////////////////

invariant pairSymmetry(address tokenA, address tokenB)
    getPairAddress(tokenA, tokenB) == getPairAddress(tokenB, tokenA)

rule pairCannotBeCreatedAgain(address tokenA, address tokenB)
{
    requireInvariant pairSymmetry(tokenA, tokenB);
    env e;
    bool pairAddressNonZero = (getPairAddress(tokenA, tokenB) !=0);
    createPair@withrevert(e, tokenA, tokenB);
    bool createReverted = lastReverted;

    assert pairAddressNonZero => createReverted;
}

rule pairSetNonZeroAddress(address tokenA, address tokenB)
{
    requireInvariant pairSymmetry(tokenA,tokenB);
    env e;
    createPair(e, tokenA, tokenB);
    assert (getPairAddress(tokenA, tokenB) !=0); // and therefore getPairAddress(tokenB, tokenA) !=0 as well
}

