def whyrun_supported?
  true
end

use_inline_resources

action :add do
  home = ::Dir.home(new_resource.user)
  group = ::Etc.getpwnam(new_resource.user).gid
  ssh_dir = "#{home}/.ssh"
  id_rsa = ::File.join(ssh_dir, 'id_rsa')
  id_rsa_pub = ::File.join(ssh_dir, 'id_rsa.pub')
  ssh_known_host 'github.com' do
    user new_resource.user
    fingerprint '16:27:ac:a5:76:28:2d:36:63:1b:56:4d:eb:df:a6:48'
  end
  ssh_known_host 'gitlab.upc.biz' do
    user new_resource.user
    fingerprint 'b9:34:b6:51:bb:bd:9a:b9:21:b5:70:d6:8b:78:7b:2e'
  end
  directory ssh_dir do
    owner new_resource.user
    group group
    mode 0700
  end
  s3_file id_rsa do
    bucket new_resource.aws_s3_bucket
    remote_path '/id_rsa'
    checksum '82bd6a8823c59102972ffedfb773fe1c60323912f7d23afab4ebfdf972d673ac'
    aws_access_key_id new_resource.aws_access_key_id
    aws_secret_access_key new_resource.aws_secret_access_key
    owner new_resource.user
    group group
    mode 0600
  end
  s3_file id_rsa_pub do
    bucket new_resource.aws_s3_bucket
    remote_path '/id_rsa.pub'
    checksum '8787b0eb65fea99ae22ad0fc6562ef796c7526fdfdad01fa37e111e1903f4c1e'
    aws_access_key_id new_resource.aws_access_key_id
    aws_secret_access_key new_resource.aws_secret_access_key
    owner new_resource.user
    group group
    mode 0644
  end
end
