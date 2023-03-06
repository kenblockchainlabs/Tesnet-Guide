###########################################
#    Copyright (C) 2023 MOI14s Nodes.     #
###########################################

exists()
{
  command -v "$1" >/dev/null 2>&1
}
if exists curl; then
echo ''
else
  sudo apt update && sudo apt install curl -y < "/dev/null"
fi
bash_profile=$HOME/.bash_profile
if [ -f "$bash_profile" ]; then
    . $HOME/.bash_profile
fi
sleep 1 && curl -s https://raw.githubusercontent.com/MOI14s/MOI14s_Nodes/main/MOI14s.sh | bash && sleep 1

# Variable
PROJECT="SAO Network"
BRANCH=testnet0
BINARY=saod
CHAIN=sao-testnet0
GIT="https://github.com/SaoNetwork/sao-consensus.git"
GIT_FOLDER=sao-consensus
FOLDER=.sao
DENOM=sao
GENESIS=https://ss-t.sao.nodestake.top/genesis.json
ADDRBOOK=https://ss-t.sao.nodestake.top/Addrbook.json
GO_VERSION=1.19.1

echo "export PROJECT=${PROJECT}" >> $HOME/.bash_profile
echo "export CHAIN=${CHAIN}" >> $HOME/.bash_profile
source $HOME/.bash_profile

if [ ! $NODENAME ]; then
read -p "👉🏼 SET NODE NAME: " NODENAME
echo 'export NODENAME='\"${NODENAME}\" >> $HOME/.bash_profile
fi
echo "❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇"
echo -e "👉🏼 PROJECT NAME: \n\e[42m$PROJECT\e[0m\n"
echo -e "👉🏼 NODE CHAIN: \n\e[42m$CHAIN\e[0m\n"
echo -e "👉🏼 U NODE NAME: \n\e[42m$NODENAME\e[0m\n"
echo "❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇"

#Install GO
echo -e '\n\e[42mINSTALL GO\e[0m\n' && sleep 1
if [ ! -f "/usr/local/go/bin/go" ]; then
    wget -O go.tar.gz https://go.dev/dl/go$GO_VERSION.linux-amd64.tar.gz
    sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go.tar.gz && rm go.tar.gz
    echo 'export GOROOT=/usr/local/go' >> $HOME/.bash_profile
    echo 'export GOPATH=$HOME/go' >> $HOME/.bash_profile
    echo 'export GO111MODULE=on' >> $HOME/.bash_profile
    echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> $HOME/.bash_profile && . $HOME/.bash_profile
    go version
fi

# Update & Install Package
echo -e '\n\e[42mUPDATE & PACKAGE\e[0m\n' && sleep 1
cd $HOME
sudo apt -q update
sudo apt -qy install make curl chrony git jq lz4 build-essential
sudo apt -qy upgrade< "/dev/null"

# Git Clone
echo -e '\n\e[42mGIT & INSTALL\e[0m\n' && sleep 1
cd $HOME
git clone $GIT
cd $GIT_FOLDER
git checkout $BRANCH
make install
sudo mv ~/go/bin/saod /usr/local/bin/saod || exit

# Init
$BINARY init "$NODENAME" --chain-id $CHAIN

# Set Peers & Seeds
PEERS="a5298771c624a376fdb83c48cc6c630e58092c62@192.18.136.151:26656,59cef823c1a426f15eb9e688287cd1bc2b6ea42d@152.70.126.187:26656,0b777727937be8664a65ea0f8abc082e725879be@185.188.249.18:10656,c196d06c9c37dee529ca167701e25f560a054d6d@3.35.136.39:26656,af7259853f202391e624c612ff9d3de1142b4ca4@52.77.248.130:26656,4121480013952e4acba82084b894079889958d68@185.209.229.14:20656"
SEEDS="59cef823c1a426f15eb9e688287cd1bc2b6ea42d@152.70.126.187:26656,a5298771c624a376fdb83c48cc6c630e58092c62@192.18.136.151:26656,af7259853f202391e624c612ff9d3de1142b4ca4@52.77.248.130:26656,c196d06c9c37dee529ca167701e25f560a054d6d@3.35.136.39:26656"
sed -i -e "s|^persistent_peers *=.*|persistent_peers = \"$PEERS\"|" $HOME/$FOLDER/config/config.toml
sed -i -e "s|^seeds *=.*|seeds = \"$SEEDS\"|" $HOME/$FOLDER/config/config.toml

# Download Genesis & AddrBook
curl -Ls $GENESIS > $HOME/$FOLDER/config/genesis.json
curl -Ls $ADDRBOOK > $HOME/$FOLDER/config/Addrbook.json

pruning="custom"
pruning_keep_recent="100"
pruning_keep_every="0"
pruning_interval="10"
sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" $HOME/$FOLDER/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $HOME/$FOLDER/config/app.toml
sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $HOME/$FOLDER/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $HOME/$FOLDER/config/app.toml

# Enable Snapshots
$BINARY tendermint unsafe-reset-all --home $HOME/$FOLDER --keep-addr-book
SNAP_NAME=$(curl -s https://ss-t.sao.nodestake.top/ | egrep -o ">20.*\.tar.lz4" | tr -d ">")
curl -o - -L https://ss-t.sao.nodestake.top/${SNAP_NAME}  | lz4 -c -d - | tar -x -C $HOME/.sao

# Create Service
echo -e '\n\e[42mCREATING A SERVICE\e[0m\n' && sleep 1

echo "[Unit]
Description=$PROJECT
After=network.target

[Service]
User=$USER
Type=simple
ExecStart=/usr/local/bin/$BINARY start
Restart=on-failure
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target" > $HOME/$BINARY.service
sudo mv $HOME/$BINARY.service /etc/systemd/system
sudo tee <<EOF >/dev/null /etc/systemd/journald.conf
Storage=persistent
EOF

# Start Service
echo -e '\n\e[42mRUNNING SERVICES\e[0m\n' && sleep 1
sudo systemctl restart systemd-journald
sudo systemctl daemon-reload
sudo systemctl enable $BINARY
sudo systemctl restart $BINARY

# SetUp Done
echo -e '\n\e[42mSETUP DONE\e[0m\n' && sleep 1
if [[ `service $BINARY status | grep active` =~ "running" ]]; then
  echo -e "❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇"
  echo -e "YOUR $PROJECT NODE :\e[32mSUCCES INSTALLED\e[39m!"
  echo -e "CHECK RUNNING LOGS : \e[1m\e[31mjournalctl -fu $BINARY -o cat\e[0m"
  echo -e "CEK NODE STATUS : \e[1m\e[31mservice $BINARY status\e[0m"
  echo -e "❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇❇"
else
  echo -e "YOUR $PROJECT NODE \e[31mWas not INSTALLED correctly\e[39m, Please REINSTALL."
fi
