def whyrun_supported?
  true
end

use_inline_resources

action :add do
  license = "#{Chef::Config[:file_cache_path]}/vagrant-vmware-workstation-license.lic"
  s3_file license do
    remote_path '/vagrant-vmware-workstation-license.lic'
    bucket new_resource.aws_s3_bucket
    aws_access_key_id new_resource.aws_access_key_id
    aws_secret_access_key new_resource.aws_secret_access_key
    mode 0644
    checksum '7965c83252ef89d46ff02f5e6e2e1ebf1dd7b45d0aeeaac3184af90eb626165e'
  end
  vagrant_plugin 'vagrant-vmware-workstation' do
    user new_resource.user
    license license
  end
end
