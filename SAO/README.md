<p align="center">
<img sizes="(max-width: 600px) 480px, 800px" src="https://raw.githubusercontent.com/MOI14s/Testnet-Node/main/SAO%20Network/SAO.png"></p>
  
<div id="badges">
  <p align="center">
   <a href="https://www.sao.network/">
  <img src="https://img.shields.io/badge/Website-4285F4?style=for-the-badge&logo=GoogleChrome&logoColor=white&style=flat"/>
  <a href="https://twitter.com/SAONetwork">
    <img src="https://img.shields.io/badge/Twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white&style=flat"/>
  </a>
  <a href="https://discord.gg/e4rxmgK7">
    <img src="https://img.shields.io/badge/Discord-%235865F2.svg?style=for-the-badge&logo=discord&logoColor=white&style=flat"/>
  </a>
  </p>
</div>

## OFFICIAL DOCUMENTS
- Docs : https://docs.sao.network/
- Run Node : https://docs.sao.network/participate-in-sao-network
- Faucet : https://faucet.testnet.sao.network/
     
## EXPLORER
https://explorer.nodestake.top/sao-testnet/staking/saovaloper17xf4muwm3yjphq93hzjr098500ltelmc5dlqmj
     
## REQUIREMENTS
> Minimum Hardware Specifications that will be used to run the node
    
| vCPU | RAM | DISK | OS |
| :--  | :-- | :--- | :- |
| 4+ | 8+ | 100+ GB | ![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)|

## GETTING STARTED
> In the automated script below it is ready to install the required requirements
#### Automatic Installations
You can manage SAO Network Incentivized Testnet `Consensus Node` easily and quickly via the automated script below
```javascript
wget -q -O sao.sh https://raw.githubusercontent.com/MOI14s/Testnet-Node/main/SAO%20Network/sao.sh && chmod +x sao.sh && sudo /bin/bash sao.sh
```
Next
```javascript
source $HOME/.bash_profile
```
#### Import Keys Wallet
```javascript
saod keys add <wallet_name> --recover
```

#### Create Validator
```javascript
saod tx staking create-validator \
  --amount=10000000sao \
  --pubkey=$(saod tendermint show-validator) \
  --moniker="<your moniker>" \
  --chain-id=sao-testnet0 \
  --commission-rate="0.10" \
  --commission-max-rate="0.20" \
  --commission-max-change-rate="0.01" \
  --min-self-delegation="1000000" \
  --gas="2000000" \
  --gas-prices="0.0025sao" \
  --from=<wallet_name>
  ```

#### Download Genesis
```javascript
curl -Ls https://ss-t.sao.nodestake.top/genesis.json > $HOME/.sao/config/genesis.json
````

#### Download Addrbook
```javascript
curl -Ls https://ss-t.sao.nodestake.top/Addrbook.json > $HOME/.sao/config/Addrbook.json
```

## USEFULL COMMAND
> Some useful commands that can be used to manage and monitor nodes

**Check Node Info**
```javascript
saod status 2>&1 | jq .NodeInfo
```
**Check Validator Info**
```javascript
saod status 2>&1 | jq .ValidatorInfo
```
**Check SYNC Info**
```javascript
saod status 2>&1 | jq .SyncInfo
```
**Restart Node**
```javascript
systemctl restart saod
```
**Check Node Logs**
```javascript
sudo journalctl -u saod -f --no-hostname -o cat
```

## REMOVE NODE
> Please, before deleting Node ! Make sure you have backed up your `priv_validator_key.json`

```javascript
systemctl stop saod
systemctl disable saod
rm -rf $(which saod) ~/sao-consensus ~/.sao /etc/systemd/system/saod.service
```

<hr/>
<p align="center"> Copyright ©2023 <b>MOI14s Nodes</b>. All rights reserved.
<p align="center">Thanks to <a href="https://nodestake.top/">NodeStake</a> & All Friends.</p>
