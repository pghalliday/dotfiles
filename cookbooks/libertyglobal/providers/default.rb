def whyrun_supported?
  true
end

use_inline_resources

action :add do
  %w{
    vagrant-office
  }.each do |name|
    project name do
      user new_resource.user
      repository "git@gitlab.upc.biz:phalliday/#{name}.git"
      email 'phalliday@libertyglobal.com'
    end
  end
  bash_alias 'office-up' do
    user new_resource.user
    command 'cd ~/projects/vagrant-office/;vagrant up'
    subshell true
  end
  bash_alias 'office-halt' do
    user new_resource.user
    command 'cd ~/projects/vagrant-office/;vagrant halt'
    subshell true
  end
  bash_alias 'office-destroy' do
    user new_resource.user
    command 'cd ~/projects/vagrant-office/;vagrant destroy'
    subshell true
  end
end
