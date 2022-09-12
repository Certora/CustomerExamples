import "../summarizations/sqrt_summarization.spec"

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

    sqrt(uint256 x) => floorSqrtSummarization(x)
    uniswapV2Call(address, uint, uint, bytes) => NONDET

	transfer(address, uint256) returns (bool) => DISPATCHER(true)
    balanceOf(address) returns (uint) => DISPATCHER(true)

	////////////////////////////////////////
	// ERC20 methods

	token0.balanceOf(address) returns (uint) envfree
	token0.totalSupply() returns (uint) envfree
	token0.transfer(address,uint256) returns (bool)

	token1.balanceOf(address) returns (uint) envfree
	token1.totalSupply() returns (uint) envfree
	token1.transfer(address,uint256) returns (bool)

	////////////////////////////////////////
	// CERTORA: getters and auxilary computational functions

	getToken0() returns (address) envfree
	getToken1() returns (address) envfree
	getLPToken() returns (address) envfree
	getFactory() returns (address) envfree

    getToken0Balance() returns (uint256) envfree
    getToken1Balance() returns (uint256) envfree

    getToken0Reserve() returns (uint112) envfree
    getToken1Reserve() returns (uint112) envfree
	////////////////////////////////////////
	}