%w{
  python3
  pandoc
}.each do |package_name|
  package package_name
end

tmuxomatic_dir = '/usr/local/src/tmuxomatic'

directory tmuxomatic_dir do
  recursive true
end

git tmuxomatic_dir do
  repository 'https://github.com/pghalliday/tmuxomatic.git'
  notifies :run, 'bash[install tmuxomatic]', :immediately
end

bash 'install tmuxomatic' do
  code <<-EOH
    pandoc -f markdown -t rst README.md -o README.rst
    python3 setup.py install
    EOH
  cwd tmuxomatic_dir
  action :nothing
end
