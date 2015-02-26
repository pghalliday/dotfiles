source = 'http://www.perforce.com/downloads/perforce/r14.3/bin.linux26x86_64/p4v.tgz'
checksum = '060d7daf8dd74798e16f66d8b41557feae427902bd682e3cd79a1ac97382e3d9'
tarball = ::File.join(Chef::Config[:file_cache_path], 'p4v.tgz')

remote_file tarball do
  source source
  checksum checksum
  notifies :run, 'bash[install p4v]', :immediately 
end

bash 'install p4v' do
  code <<-EOH
tar -zxf #{tarball} --strip-components=1
EOH
  cwd '/usr'
  action :nothing
end
