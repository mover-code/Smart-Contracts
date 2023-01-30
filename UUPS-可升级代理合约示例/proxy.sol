// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract UUPSProxy {
    // 存储数据的变量
    address public implementation; // 逻辑合约地址
    address public admin; // admin地址
    string public words; // 字符串，可以通过逻辑合约的函数改变

    event FallBACK(bool,bytes);

    // 构造函数，初始化admin和逻辑合约地址
    constructor(address _implementation){
        admin = msg.sender;
        implementation = _implementation;
    }

    // 存在多个逻辑合约地址可以使用函数方式构造
    function callLogicFirst(bytes calldata _data) external {
        (bool success, bytes memory data) = implementation.delegatecall(_data);
        emit FallBACK(success,data);
    }

    // fallback函数，将调用委托给逻辑合约 , 只有一个逻辑合约时可以使用此方式

    // fallback() external payable {
    //     (bool success, bytes memory data) = implementation.delegatecall(msg.data);
    //     emit FallBACK(success,data);
    // }

    // receive() external payable{
    // }
}