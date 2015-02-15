def whyrun_supported?
  true
end

use_inline_resources

action :add do
  home = ::Dir.home(new_resource.user)
  group = ::Etc.getpwnam(new_resource.user).gid
  development = "#{home}/development"
  helios = "#{development}/helios"
  directory development do
    owner new_resource.user
    group group
    mode 0755
  end
  directory helios do
    owner new_resource.user
    group group
    mode 0755
  end
  bash_alias 'h-mount' do
    user new_resource.user
    command 'sudo mount -t nfs -o proto=tcp,port=2049 192.168.50.3:/helios ~/development/helios/vm'
  end
  bash_alias 'h-umount' do
    user new_resource.user
    command 'sudo umount ~/development/helios/vm'
  end
  bash_alias 'h-ssh' do
    user new_resource.user
    command 'ssh heliosdev@192.168.50.3'
  end
  bash_alias 'h-cd' do
    user new_resource.user
    command 'cd ~/development/helios/vm'
  end
  tmuxomatic 'helios-application-framework' do
    user new_resource.user
    cookbook 'helios'
    source 'tmuxomatic/helios-application-framework'
  end
  project 'development/helios/development-infrastructure' do
    user new_resource.user
    cookbook 'helios'
    tmuxomatic 'tmuxomatic/helios-development-infrastructure'
    repository 'git@gitlab.upc.biz:helios/development-infrastructure'
    email 'phalliday@libertyglobal.com'
  end
  project 'development/helios/helios-jira-project-analysis' do
    user new_resource.user
    cookbook 'helios'
    tmuxomatic 'tmuxomatic/helios-jira-project-analysis'
    repository 'git@gitlab.upc.biz:phalliday/helios-jira-project-analysis.git'
    email 'phalliday@libertyglobal.com'
  end
  project 'development/helios/local-dev-vm-setup' do
    user new_resource.user
    repository 'git@gitlab.upc.biz:helios/local-dev-vm-setup.git'
    email 'phalliday@libertyglobal.com'
  end
end
