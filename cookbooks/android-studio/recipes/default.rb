install_dir = node['android-studio']['install_dir']
cache = Chef::Config[:file_cache_path]

basename = 'android-studio-ide-141.1890965-linux'
zip_url = "https://dl.google.com/dl/android/studio/ide-zips/1.2.0.12/#{basename}.zip"
checksum = 'f6c083902156ab83435fa91ae0743d9a2ae64e8aca1396afd553a44071366906'
zip = ::File.join(cache, "#{basename}.zip")
dir = ::File.join(install_dir, basename)

unzipped_dir = ::File.join(install_dir, 'android-studio')
current_dir = ::File.join(install_dir, 'current')

package 'zip'

directory install_dir do
  recursive true
end

remote_file zip do
  source zip_url
  checksum checksum
end

bash 'install android studio' do
  code <<-EOH
    unzip #{zip} -d #{install_dir}
    mv #{unzipped_dir} #{dir}
    EOH
  not_if { ::File.exist?(dir) }
end

link current_dir do
  to dir
end
