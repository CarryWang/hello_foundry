### contract address

nftmarketV1:
`0x45Cc1f10Fa6b75B9903D4e5155e77B695907cf86`

proxy:
`0x1959BD1A3c923A40a8e1b8d62dc830041726a95f`

nftmarketV2:
`0x1a561fA0a3eC3c788203aD84a68B4DB46a572B79`

---

```
forge script script/upgradeable/NFTUpdate.s.sol:NFTUpdateScript --rpc-url https://rpc.particle.network/evm-chain\?chainId\=11155111\&projectUuid\=c8036f73-ee6d-4dd8-8ecd-e8009fe07ab4\&projectKey\=clwo7Hyz4sVTSw5BWz5jYzkYxt5VrqzSOEpWq3br --broadcast --verify --sender 0xa0466a82B961e85077d4a8DEBC35fbF6Cf18D464
```

[⠊] Compiling...

[⠘] Compiling 87 files with 0.8.25

[⠒] Solc 0.8.25 finished in 4.88s
Compiler run successful!
Script ran successfully.

## Setting up 1 EVM.

==========================

Chain 11155111

Estimated gas price: 299.170104896 gwei

Estimated total gas used for script: 5070300

Estimated amount required: 1.5168821828541888 ETH

==========================
Enter keystore password:

##

Sending transactions [0 - 5].
⠂ [00:00:04] [######################################################################] 6/6 txes (0.0s)##
Waiting for receipts.
⠂ [00:00:09] [##################################################################] 6/6 receipts (0.0s)

##### sepolia

✅ [Success]Hash: 0x3ef0737c824d2273ea2717fe6fdac1c9e3305f64049f8a857783d7de9469059b
Contract Address: 0xa6Cd1eC60513a3B4AC9a5E3d47B588a1f243952a
Block: 5860052
Paid: 0.136032336321445728 ETH (994782 gas \* 136.745876304 gwei)

##### sepolia

✅ [Success]Hash: 0xdadb912a2f063f7c94c169131d5d1909b568d567b8513c9ce698abb6ad7058f0
Contract Address: 0xADA6688B04a57C8e74356015B4c297574e99478e
Block: 5860052
Paid: 0.136852127849888208 ETH (1000777 gas \* 136.745876304 gwei)

##### sepolia

✅ [Success]Hash: 0x45a01eaaf3961c85d315b7ed8074070ec305ab137d06753f46e0c17937719b07
Contract Address: 0x45Cc1f10Fa6b75B9903D4e5155e77B695907cf86
Block: 5860052
Paid: 0.071029363545081504 ETH (519426 gas \* 136.745876304 gwei)

##### sepolia

✅ [Success]Hash: 0x9a022804f04d38bf4bb9c0c83ee4ecca5719259fb18a21c5d0fe84186e14e9fa
Contract Address: 0x1959BD1A3c923A40a8e1b8d62dc830041726a95f
Block: 5860052
Paid: 0.100328808493729152 ETH (733688 gas \* 136.745876304 gwei)

##### sepolia

✅ [Success]Hash: 0x94dfe64e647b4504fb467df37e1a96958861207a2819d46d45b52fedcdfa7a1f
Contract Address: 0x1a561fA0a3eC3c788203aD84a68B4DB46a572B79
Block: 5860052
Paid: 0.083767925652180624 ETH (612581 gas \* 136.745876304 gwei)

##### sepolia

✅ [Success]Hash: 0xcfca7188e96d49fbe9626a14ecf37d4eef72b838d18bf05f122673f15eda5d38
Block: 5860052
Paid: 0.005177609114498352 ETH (37863 gas \* 136.745876304 gwei)

==========================

ONCHAIN EXECUTION COMPLETE & SUCCESSFUL.
Total Paid: 0.533188170976823568 ETH (3899117 gas \* avg 136.745876304 gwei)

##

Start verification for (6) contracts
Start verifying contract `0xa6Cd1eC60513a3B4AC9a5E3d47B588a1f243952a` deployed on sepolia

Submitting verification for [src/upgradeable/TokenPermit.sol:TokenPermit] 0xa6Cd1eC60513a3B4AC9a5E3d47B588a1f243952a.

Submitting verification for [src/upgradeable/TokenPermit.sol:TokenPermit] 0xa6Cd1eC60513a3B4AC9a5E3d47B588a1f243952a.

Submitting verification for [src/upgradeable/TokenPermit.sol:TokenPermit] 0xa6Cd1eC60513a3B4AC9a5E3d47B588a1f243952a.

Submitting verification for [src/upgradeable/TokenPermit.sol:TokenPermit] 0xa6Cd1eC60513a3B4AC9a5E3d47B588a1f243952a.

Submitting verification for [src/upgradeable/TokenPermit.sol:TokenPermit] 0xa6Cd1eC60513a3B4AC9a5E3d47B588a1f243952a.
Submitted contract for verification:
Response: `OK`
GUID: `urupe36ujt4qhwcjvr3si95vvtdgthrqx23apgtwydvzaqztbh`
URL: https://sepolia.etherscan.io/address/0xa6cd1ec60513a3b4ac9a5e3d47b588a1f243952a
Contract verification status:
Response: `NOTOK`
Details: `Pending in queue`
Contract verification status:
Response: `OK`
Details: `Pass - Verified`
Contract successfully verified
Start verifying contract `0xADA6688B04a57C8e74356015B4c297574e99478e` deployed on sepolia

Submitting verification for [src/upgradeable/NFTPermit.sol:NFTPermit] 0xADA6688B04a57C8e74356015B4c297574e99478e.
Submitted contract for verification:
Response: `OK`
GUID: `g7n6njmzjlpptc3ejfttwfyyjfe5k7tjgk1itreipgxgfjbtxm`
URL: https://sepolia.etherscan.io/address/0xada6688b04a57c8e74356015b4c297574e99478e
Contract verification status:
Response: `NOTOK`
Details: `Pending in queue`
Contract verification status:
Response: `OK`
Details: `Pass - Verified`
Contract successfully verified
Start verifying contract `0x45Cc1f10Fa6b75B9903D4e5155e77B695907cf86` deployed on sepolia

Submitting verification for [src/upgradeable/NFTMarketV1.sol:NFTMarketV1] 0x45Cc1f10Fa6b75B9903D4e5155e77B695907cf86.
Submitted contract for verification:
Response: `OK`
GUID: `6js8cs9pl8fhecsw8hbjltsj5ehhtbwl7y2atzyaade64g3kpa`
URL: https://sepolia.etherscan.io/address/0x45cc1f10fa6b75b9903d4e5155e77b695907cf86
Contract verification status:
Response: `NOTOK`
Details: `Pending in queue`
Contract verification status:
Response: `OK`
Details: `Pass - Verified`
Contract successfully verified
Start verifying contract `0x1959BD1A3c923A40a8e1b8d62dc830041726a95f` deployed on sepolia

Submitting verification for [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy] 0x1959BD1A3c923A40a8e1b8d62dc830041726a95f.
Submitted contract for verification:
Response: `OK`
GUID: `buhebcsi3y9rwbeuafbhca92z8emgqcyuiz1utppibvarjhus9`
URL: https://sepolia.etherscan.io/address/0x1959bd1a3c923a40a8e1b8d62dc830041726a95f
Contract verification status:
Response: `NOTOK`
Details: `Pending in queue`
Contract verification status:
Response: `OK`
Details: `Pass - Verified`
Contract successfully verified
Start verifying contract `0x3298447f238a2410A79aeF8AaD196bBc876e6560` deployed on sepolia

Submitting verification for [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/ProxyAdmin.sol:ProxyAdmin] 0x3298447f238a2410A79aeF8AaD196bBc876e6560.
Submitted contract for verification:
Response: `OK`
GUID: `6mzxz2jfgtxx2elcnebeshsnas4abeslvxiryx9ygddvrb9rnp`
URL: https://sepolia.etherscan.io/address/0x3298447f238a2410a79aef8aad196bbc876e6560
Contract verification status:
Response: `NOTOK`
Details: `Pending in queue`
Contract verification status:
Response: `OK`
Details: `Pass - Verified`
Contract successfully verified
Start verifying contract `0x1a561fA0a3eC3c788203aD84a68B4DB46a572B79` deployed on sepolia

Submitting verification for [src/upgradeable/NFTMarketV2.sol:NFTMarketV2] 0x1a561fA0a3eC3c788203aD84a68B4DB46a572B79.
Submitted contract for verification:
Response: `OK`
GUID: `xthniqvcw8ykes2ccwmmdq5dyduwvphclmhyw8ptwm221vzmuf`
URL: https://sepolia.etherscan.io/address/0x1a561fa0a3ec3c788203ad84a68b4db46a572b79
Contract verification status:
Response: `NOTOK`
Details: `Pending in queue`
Contract verification status:
Response: `OK`
Details: `Pass - Verified`
Contract successfully verified
All (6) contracts were verified!

Transactions saved to: /Users/carry/web3/hello_foundry/broadcast/NFTUpdate.s.sol/11155111/run-latest.json

Sensitive values saved to: /Users/carry/web3/hello_foundry/cache/NFTUpdate.s.sol/11155111/run-latest.json
