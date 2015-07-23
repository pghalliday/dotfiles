homebrew_cask 'virtualbox' do
  notifies :run, 'bash[install VirtualBox extension pack]', :immediately
end
group 'vboxusers'
