// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Swapper.sol";
import "../src/YitToken.sol";
import "../src/BitToken.sol";


contract SwapperTest is Test {
    Swapper public swap;
    YitToken public Yit;
    BitToken public Bit;

    address customer; //user comming to place order
    address executor; //user who is executing the order
    address owner;

    function setUp() public{
        swap = new Swapper();
        Yit = new YitToken(customer);
        Bit = new BitToken(executor);
        vm.startPrank(owner);
        ERC20(address(Yit)).transfer(address(swap), 4000e18);
        ERC20(address(Bit)).transfer(address(swap), 5000e18);
        vm.stopPrank();
        
    }

    function testSwapper() public{
        vm.startPrank(customer);
        ERC20(address(Yit)).approve(address(swap), 2000e18);
        swap.placeOrder(address(Yit), address(Bit), 2000e18, 3000e18);
        vm.stopPrank();
        vm.startPrank(executor);
        ERC20(address(Bit)).approve(address(swap), 3000e18);
        swap.executeOrder(1);
        vm.stopPrank;
    }

    
    function getCustomerBalance() public view returns(uint256){
        return ERC20(address(Bit)).balanceOf(customer);
    }

    function getExecutorBal() public view returns(uint256){
        return ERC20(address(Yit)).balanceOf(executor);
    }

  
}
