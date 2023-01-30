// UUPS逻辑合约（升级函数写在逻辑合约内）
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract UUPS1 {
    // 状态变量和proxy合约一致，防止插槽冲突
    address public implementation;
    address public admin;
    string public words; // 字符串，可以通过逻辑合约的函数改变

    // 改变proxy中状态变量，
    function foo(string calldata _str) public {
        words = _str;
    }

    // 将变量重新赋值
    function re() external {
        words = "gg";
    }

    // 升级函数，改变逻辑合约地址，只能由admin调用。选择器：0x0900f010
    // UUPS中，逻辑函数中必须包含升级函数，不然就不能再升级了。
    function upgrade(address newImplementation) external {
        require(msg.sender == admin);
        implementation = newImplementation;
    }
}
