dotfiles
========

Prerequisites
-------------

Install ChefDK - https://downloads.chef.io/chef-dk/

Usage
-----

Create the file `~/.dotfiles/attributes.json` with the correct settings

```
{
  "workstation": {
    "user": "user",
    "aws_s3_bucket": "bucket",
    "aws_access_key_id": "id",
    "aws_secret_access_key": "secret"
  }
}
```

Then run

```
./converge.sh
```
