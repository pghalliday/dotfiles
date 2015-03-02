dotfiles
========

Prerequisites
-------------

Install Chef client

```sh
wget -O- https://www.opscode.com/chef/install.sh | sudo bash
```

Usage
-----

Create the file `~/.dotfiles/attributes.json` with the correct settings

```sh
cat > ~/.dotfiles//attributes.json << EOH
{
  "workstation": {
    "user": "user",
    "aws_s3_bucket": "bucket",
    "aws_access_key_id": "id",
    "aws_secret_access_key": "secret"
  }
}
EOH
```

Download and unpack the cookbook tarball

```sh
wget -O cookbooks.tar.gz https://github.com/pghalliday/dotfiles/tarball/vendor
tar -zxf cookbooks.tar.gz
cd pghalliday-dotfiles-*
```

Then run

```sh
./converge.sh
```

Development
-----------

Once converged (as above), change to the repository working directory, make changes to cookbooks then run

```sh
./all.sh
```
