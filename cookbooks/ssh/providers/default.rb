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
  directory ssh_dir do
    owner new_resource.user
    group group
    mode 0700
  end
  s3_file id_rsa do
    bucket new_resource.aws_s3_bucket
    remote_path '/id_rsa'
    checksum 'afdd48efbbeec3835562298d6ff0965ffb22fad7a352f01d3848764c279934f9'
    aws_access_key_id new_resource.aws_access_key_id
    aws_secret_access_key new_resource.aws_secret_access_key
    owner new_resource.user
    group group
    mode 0600
  end
  s3_file id_rsa_pub do
    bucket new_resource.aws_s3_bucket
    remote_path '/id_rsa.pub'
    checksum '527d95cde70d905005754259e7596ecab8751c340bc877290f6a548b5868f805'
    aws_access_key_id new_resource.aws_access_key_id
    aws_secret_access_key new_resource.aws_secret_access_key
    owner new_resource.user
    group group
    mode 0644
  end
  ssh_known_host 'github.com' do
    user new_resource.user
    fingerprint '16:27:ac:a5:76:28:2d:36:63:1b:56:4d:eb:df:a6:48'
  end
  ssh_known_host 'gitlab.upc.biz' do
    user new_resource.user
    fingerprint 'b9:34:b6:51:bb:bd:9a:b9:21:b5:70:d6:8b:78:7b:2e'
  end
end
