////////////////////////////////////////////////////////////////////////////
//                       Methods                                          //
////////////////////////////////////////////////////////////////////////////

methods{
    feeTo() returns (address)
    feeToSetter() returns (address)
    getPairAddress(address, address) returns (address) envfree
    allPairsLength() returns (uint) envfree
    createPair(address, address) returns (address)
    setFeeTo(address) 
    setFeeToSetter(address) 
    initialize(address, address) => DISPATCHER(true);
}

