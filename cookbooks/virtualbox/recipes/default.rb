cache = ::File.join(Chef::Config[:file_cache_path], 'virtualbox')
directory cache
apt_repository 'virtualbox' do
  uri 'http://download.virtualbox.org/virtualbox/debian'
  distribution node['lsb']['codename']
  components ['contrib']
  key 'https://www.virtualbox.org/download/oracle_vbox.asc'
end
package 'dkms'
package 'virtualbox-4.3' do
  timeout 1800
  notifies :run, 'bash [install VirtualBox extension pack]', :immediately
end
bash 'install VirtualBox extension pack' do
  code <<-EOH
    version=$(VBoxManage --version)
    IFS='r' read -a versions <<< "${version}"
    shasums_url=https://www.virtualbox.org/download/hashes/${versions[0]}
    extpack=Oracle_VM_VirtualBox_Extension_Pack-${versions[0]}-${versions[1]}.vbox-extpack
    extpack_url=http://download.virtualbox.org/virtualbox/${versions[0]}
    wget -O SHA256SUMS ${shasums_url}/SHA256SUMS
    wget -O ${extpack} ${extpack_url}/${extpack}
    grep ${extpack} SHA256SUMS > SHA256SUM
    sha256sum -c SHA256SUM
    VBoxManage extpack install --replace ${extpack}
  EOH
  cwd cache
  action :nothing
end
