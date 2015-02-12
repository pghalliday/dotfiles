dotfiles
========

Prerequisites
-------------

Install ChefDK - https://downloads.chef.io/chef-dk/

Usage
-----

To do everything in one go

```
./all.sh
```

OR on step at a time:

To install packages, etc

```
chef exec berks vendor cookbooks
sudo chef exec chef-client -z -r workstation
```

Then configure options

```
./converge.sh
```
