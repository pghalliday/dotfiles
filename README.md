dotfiles
========

Prerequisites
-------------

Install curl

```
sudo apt-get install curl
```

Install chef client (including chef solo)

```
curl -L https://www.chef.io/chef/install.sh | sudo bash
```

Usage
-----

To install packages, etc

```
sudo chef-client -z -r workstation
```

Then configure options

```
./converge.sh
```
