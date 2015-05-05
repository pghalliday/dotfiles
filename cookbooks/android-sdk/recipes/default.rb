install_dir = node['android-sdk']['install_dir']
cache = Chef::Config[:file_cache_path]

basename = 'android-sdk_r24.2-linux'
tar_url = "http://dl.google.com/android/#{basename}.tgz"
checksum = 'c07ade2f984e108fc24d96598b45b87f4e77ff2af5e4243fa52184c3073efcf3'
tar = ::File.join(cache, "#{basename}.tgz")
dir = ::File.join(install_dir, basename)

untarred_dir = ::File.join(install_dir, 'android-sdk-linux')
current_dir = ::File.join(install_dir, 'current')

directory install_dir do
  recursive true
end

remote_file tar do
  source tar_url
  checksum checksum
end

bash 'install android sdk' do
  code <<-EOH
    tar zxf #{tar} -C #{install_dir}
    mv #{untarred_dir} #{dir}
    EOH
  not_if { ::File.exist?(dir) }
end

link current_dir do
  to dir
end
