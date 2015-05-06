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
    chown -R root:root #{dir}
    cd #{dir}
    find tools -maxdepth 1 -perm -100 -type f -print0 | xargs -0 chmod a+x
    EOH
  not_if { ::File.exist?(dir) }
end

android_sdk_package 'platform-tools' do
  android_home dir
  creates ::File.join(dir, 'platform-tools')
end

android_sdk_package 'build-tools-22.0.1' do
  android_home dir
  creates ::File.join(dir, 'build-tools/22.0.1')
end

android_sdk_package 'android-22' do
  android_home dir
  creates ::File.join(dir, 'platforms/android-22')
end

android_sdk_package 'addon-google_apis-google-22' do
  android_home dir
  creates ::File.join(dir, 'add-ons/addon-google_apis-google-22')
end

android_sdk_package 'sys-img-x86_64-addon-google_apis-google-22' do
  android_home dir
  creates ::File.join(dir, 'system-images/android-22/google_apis/x86_64')
end

link current_dir do
  to dir
end
