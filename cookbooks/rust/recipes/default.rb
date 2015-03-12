include_recipe 'build-essential::default'

src = '/usr/local/src/rust'

directory src do
  recursive true
end

git src do
  repository 'https://github.com/rust-lang/rust.git'
  notifies :run, 'bash[build and install rust]', :immediately
end

bash 'build and install rust' do
  code <<-EOH
    ./configure
    make && make install
    EOH
  cwd src
  action :nothing
end
