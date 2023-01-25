// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;
import "lib/solmate/src/tokens/ERC20.sol";
contract Swapper{
   
    event OrderPlaced(address user, address tokenFrm, address tokenTo, uint256 amountIn, uint256 amountOut);
    event OrderExecuted(address tokenFrm, address tokenTo, address executor, uint256 amountIn, uint256 amountOut);


    struct OrderDetails{
        address user;
        address tokenFrom;
        address tokenTo;
        uint256 amountIN;
        uint256 amountOUT;
        bool orderStatus;
    }

    uint256 ID = 1;
    mapping (uint => OrderDetails) _orderdetails;

    function placeOrder(address _tokenFrom, address _tokenTo, uint256 _amountIN, uint256 _amountOUT) external {
        assert(ERC20(_tokenFrom).transferFrom(msg.sender, address(this), _amountIN));
        OrderDetails storage OD = _orderdetails[ID];
        OD.user = msg.sender;
        OD.tokenFrom = _tokenFrom;
        OD.tokenTo = _tokenTo;
        OD.amountIN = _amountIN;
        OD.amountOUT = _amountOUT;
        OD.orderStatus = true;

        ID++;
        emit OrderPlaced(msg.sender, _tokenFrom, _tokenTo, _amountIN, _amountOUT);
    }
    
    function executeOrder(uint256 customerID) external{
         OrderDetails storage OD = _orderdetails[customerID];
         assert(OD.orderStatus == true);
         uint256 amount = OD.amountOUT;
         require(ERC20(OD.tokenTo).transferFrom(msg.sender, address(this), amount), "transaction failed");
         ERC20(OD.tokenFrom).transfer(msg.sender, OD.amountIN);
         ERC20(OD.tokenTo).transfer(OD.user, amount);

         emit OrderExecuted(OD.tokenFrom, OD.tokenTo, msg.sender, OD.amountIN, amount);
    }
}