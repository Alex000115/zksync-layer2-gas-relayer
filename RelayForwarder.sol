// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/utils/cryptography/MessageHashUtils.sol";

contract RelayForwarder {
    using ECDSA for bytes32;

    address public owner;
    mapping(address => uint256) public nonces;

    constructor() {
        owner = msg.sender;
    }

    function execute(
        address target,
        bytes calldata data,
        uint256 nonce,
        bytes calldata signature
    ) external payable {
        require(nonce == nonces[msg.sender], "Invalid nonce");
        
        bytes32 hash = keccak256(abi.encodePacked(msg.sender, target, data, nonce));
        bytes32 ethSignedHash = MessageHashUtils.toEthSignedMessageHash(hash);
        
        require(ethSignedHash.recover(signature) == msg.sender, "Invalid signature");

        nonces[msg.sender]++;
        
        (bool success, ) = target.call{value: msg.value}(data);
        require(success, "Execution failed");
    }
}
