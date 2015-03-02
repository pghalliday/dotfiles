install_bundle = "#{Chef::Config[:file_cache_path]}/vmware-workstation.bundle"

aws_s3_bucket = node['vmware-workstation']['aws_s3_bucket']
aws_access_key_id = node['vmware-workstation']['aws_access_key_id']
aws_secret_access_key = node['vmware-workstation']['aws_secret_access_key']

s3_file install_bundle do
	remote_path '/VMware-Workstation-Full-11.1.0-2496824.x86_64.bundle'
  bucket aws_s3_bucket
	aws_access_key_id aws_access_key_id
	aws_secret_access_key aws_secret_access_key
	mode 0755
  checksum '2106ed8e3f1e5f84a0fb366676ea6cefb1d1e2b8f5427cc46a95db32654cf84e'
  notifies :run, 'bash[install vmware workstation]', :immediately
end

bash 'install vmware workstation' do
  code <<-EOH
  #{install_bundle} --required --eulas-agreed --console
EOH
  action :nothing
end
