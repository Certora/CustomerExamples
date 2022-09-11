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
	token0.transfer(address,uint256) envfree

	token1.balanceOf(address) envfree
	token1.totalSupply() envfree
	token1.transfer(address,uint256) envfree

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