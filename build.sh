#!/bin/bash -e

sudo rm -rf ./vendor/
mkdir ./vendor/
chef exec berks vendor ./vendor/cookbooks/
cat > ./vendor/converge.sh << 'EOH'
#!/bin/bash -e
DIR=$(cd "$(dirname "$0")"; pwd)
ATTRIBUTES=$HOME/.dotfiles/attributes.json
sudo -i -- sh -c "cd $DIR && chef-client -z -j $ATTRIBUTES -r workstation"
EOH
chmod +x ./vendor/converge.sh
