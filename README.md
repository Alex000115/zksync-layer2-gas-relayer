# zkSync Layer 2 Gas Relayer

A production-ready toolkit for implementing gasless transactions on zkSync Era. This repository leverages the native Account Abstraction features of zkSync to allow users to sign transactions off-chain, which are then submitted and paid for by a centralized relayer.

## Core Features
* **EIP-712 Integration**: Securely handle typed data signing for user intent.
* **Fee Estimation**: Accurate gas calculation for L2 batches and L1 pubdata.
* **Relayer Backend**: A Node.js service that manages a private key and submits transactions to the zkSync operator.
* **Paymaster Support**: Pre-configured logic to integrate with custom Paymaster contracts.



## Technical Stack
* **L2 Network**: zkSync Era
* **Libraries**: zksync-ethers, ethers.js v6
* **Language**: TypeScript/Node.js

## Quick Start
1. Add your relayer private key to `.env`.
2. Deploy the `RelayForwarder.sol` contract to zkSync Era Testnet.
3. Start the relayer: `npm run start`.
