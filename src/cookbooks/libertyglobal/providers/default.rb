def whyrun_supported?
  true
end

use_inline_resources

action :add do
  home = ::Dir.home(new_resource.user)
  group = ::Etc.getpwnam(new_resource.user).gid
  development = "#{home}/development"
  directory development do
    owner new_resource.user
    group group
    mode 0755
  end
  %w{
    vagrant-office
  }.each do |name|
    project "development/#{name}" do
      user new_resource.user
      cookbook 'libertyglobal'
      tmuxomatic "tmuxomatic/#{name}"
      repository "git@gitlab.upc.biz:phalliday/#{name}.git"
      email 'phalliday@libertyglobal.com'
    end
  end
  bash_alias 'office-up' do
    user new_resource.user
    command 'cd ~/development/vagrant-office/;vagrant up'
    subshell true
  end
  bash_alias 'office-halt' do
    user new_resource.user
    command 'cd ~/development/vagrant-office/;vagrant halt'
    subshell true
  end
  bash_alias 'office-destroy' do
    user new_resource.user
    command 'cd ~/development/vagrant-office/;vagrant destroy'
    subshell true
  end
end
