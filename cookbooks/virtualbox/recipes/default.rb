extension_pack = ::File.join(Chef::Config[:file_cache_path], 'virtualbox.vbox-extpack')
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
    wget -O #{extension_pack} http://download.virtualbox.org/virtualbox/#{versions[0]}/Oracle_VM_VirtualBox_Extension_Pack-#{versions[0]}-#{versions[1]}.vbox-extpack
    VBoxManage extpack install --replace #{extension_pack}
  EOH
  action :nothing
end
