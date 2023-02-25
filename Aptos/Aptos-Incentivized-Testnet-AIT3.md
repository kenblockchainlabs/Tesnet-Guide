This is manual for the [Aptos Incentivized Testnet AIT3.](https://medium.com/aptoslabs/welcome-to-aptos-incentivized-testnet-3-9d7ce888205c)



[After installation, be sure to fill out the  form  and pass KYC.](https://aptoslabs.com/incentivized-testnet)

## Install

Use our script for a quick installation:


```
wget -q -O aptos_ait3.sh https://api.nodes.guru/aptos_ait3.sh && chmod +x aptos_ait3.sh && sudo /bin/bash aptos_ait3.sh
``` 

IMPORTANT: Backup your key files somewhere safe. These key files are important for you to establish ownership of your node, and you will use this information to claim your rewards later if eligible. Never share those keys with anyone else. Be sure to back up the directory $HOME/.aptos
Example of filling out the form:


![key.png](https://cdn.hashnode.com/res/hashnode/image/upload/v1662960750033/lqdyG6jpM.png align="left")

### Additional

Check validator node logs:


```
docker logs -f --tail 100 aptos-validator-1
``` 


Restart node:


```
cd ~/.aptos && docker-compose restart
``` 

Stop node:


```
cd ~/.aptos && docker-compose stop
``` 

Progress can be monitored by querying the metrics port:


```
curl 127.0.0.1:9101/metrics 2> /dev/null | grep aptos_state_sync_version
``` 

Information for filling out the form can be viewed by running the commands:


```
cat ~/.aptos/keys/public-keys.yaml
``` 

Ports used:


```
TCP ports: 80, 6180, 6181, 6182, 9101
``` 


Delete node:


```
cd ~/.aptos && docker-compose down -v
rm -rf ~/.aptos /opt/aptos
``` 
