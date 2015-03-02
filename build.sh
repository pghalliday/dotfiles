#!/bin/bash

set -e

sudo rm -rf ./vendor/
mkdir ./vendor/
chef exec berks vendor ./vendor/cookbooks/
cat > ./vendor/converge.sh << EOH
#!/bin/bash

set -e

sudo chef-client -z -j ~/.dotfiles/attributes.json -r workstation
EOH
chmod +x ./vendor/converge.sh
