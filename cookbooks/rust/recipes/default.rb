tar_url = 'https://static.rust-lang.org/dist/rust-nightly-x86_64-unknown-linux-gnu.tar.gz'
sha_url = 'https://static.rust-lang.org/dist/rust-nightly-x86_64-unknown-linux-gnu.tar.gz.sha256'

sha_command = Mixlib::ShellOut.new("wget -O- #{sha_url}")
sha_command.run_command
sha_command.error!
sha = (/^([a-f0-9]*)/.match(sha_command.stdout))[1]

cache = Chef::Config[:file_cache_path]
tar = ::File.join(cache, 'rust-nightly-x86_64-unknown-linux-gnu.tar.gz')
dir = ::File.join(cache, 'rust-nightly-x86_64-unknown-linux-gnu')

remote_file tar do
  source tar_url
  checksum sha
  notifies :run, 'bash[install rust]', :immediately
end

bash 'install rust' do
  code <<-EOH
    tar -zxf #{tar} -C #{cache}
    cd #{dir}
    ./install.sh
    EOH
  action :nothing
end
