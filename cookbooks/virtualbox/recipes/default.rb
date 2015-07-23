cache = ::File.join(Chef::Config[:file_cache_path], 'virtualbox')
directory cache

case node['platform']
when 'ubuntu'
  include_recipe 'virtualbox::ubuntu'
when 'mac_os_x'
  include_recipe 'virtualbox::mac_os_x'
end

bash 'install VirtualBox extension pack' do
  code <<-EOH
    version=$(VBoxManage --version)
    IFS='r' read -a versions <<< "${version}"
    shasums_url=https://www.virtualbox.org/download/hashes/${versions[0]}
    extpack=Oracle_VM_VirtualBox_Extension_Pack-${versions[0]}-${versions[1]}.vbox-extpack
    extpack_url=http://download.virtualbox.org/virtualbox/${versions[0]}
    wget -O ${extpack} ${extpack_url}/${extpack}
    wget -O - ${shasums_url}/SHA256SUMS | grep ${extpack} | sha256sum -c
    VBoxManage extpack install --replace ${extpack}
  EOH
  cwd cache
  action :nothing
end
