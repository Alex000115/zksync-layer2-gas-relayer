import { Wallet, Provider, types, utils } from "zksync-ethers";
import * as ethers from "ethers";

const PRIVATE_KEY = process.env.RELAYER_KEY || "";
const L2_RPC = "https://sepolia.era.zksync.dev";

async function relayTransaction(userSignature: string, transactionRequest: any) {
    const provider = new Provider(L2_RPC);
    const relayer = new Wallet(PRIVATE_KEY, provider);

    console.log("Relaying transaction for user...");

    // Populate transaction with L2 specific gas fields
    const tx = await relayer.sendTransaction({
        ...transactionRequest,
        customData: {
            gasPerPubdata: utils.DEFAULT_GAS_PER_PUBDATA_LIMIT,
        } as types.Eip712Meta,
    });

    const receipt = await tx.wait();
    console.log(`Transaction successful: ${receipt.hash}`);
}
