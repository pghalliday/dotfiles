%w{
  libpam0g:i386
  libstdc++5:i386
  libx11-6:i386
}.each do |package_name|
  package package_name
end
snx_install_script = "#{Chef::Config[:file_cache_path]}/snx_install.sh"
remote_file snx_install_script do
  source 'http://vpn.upclabs.com/download/linux-vpn-cli.sh'
  checksum '9ecba22bc3853e17b59e06860f783da084aff1e1c73827f3746e5a67d3918c08'
  mode 0700
  notifies :run, "bash[install snx]", :immediately
end
bash 'install snx' do
  code <<-EOH
#{snx_install_script}
EOH
  action :nothing
end
