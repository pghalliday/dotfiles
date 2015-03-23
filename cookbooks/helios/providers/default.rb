def whyrun_supported?
  true
end

use_inline_resources

action :add do
  bash_alias 'h-mount' do
    user new_resource.user
    command 'sudo mount -t nfs -o proto=tcp,port=2049 192.168.50.3:/helios ~/projects/helios/vm'
  end
  bash_alias 'h-umount' do
    user new_resource.user
    command 'sudo umount ~/projects/helios/vm'
  end
  bash_alias 'h-ssh' do
    user new_resource.user
    command 'ssh heliosdev@192.168.50.3'
  end
  bash_alias 'h-cd' do
    user new_resource.user
    command 'cd ~/projects/helios/vm'
  end
  bash_alias 'helios-release-analysis' do
    user new_resource.user
    command 'git-jira-utils-release-analysis "development" "origin/release/" "HS_[0-9]+\\.[0-9]+\\.[0-9]+" "\\.[a-z]"'
  end
  bash_alias 'helios-release-branch-commits' do
    user new_resource.user
    command 'echo JIRA Password for phalliday:; read -s password; git-jira-utils-branch-commits origin/release/$1 development phalliday "$password" jira.upc.biz https HEL-[0-9]*'
    arg_offset 1
  end
  bash_alias 'helios-release-diff-commits' do
    user new_resource.user
    command 'echo JIRA Password for phalliday:; read -s password; git-jira-utils-diff-commits origin/release/$1 development phalliday "$password" jira.upc.biz https HEL-[0-9]*'
    arg_offset 1
  end
  tmuxomatic 'helios-application-framework' do
    user new_resource.user
    cookbook 'helios'
    source 'tmuxomatic/helios-application-framework'
  end
  project 'helios/development-infrastructure' do
    user new_resource.user
    cookbook 'helios'
    tmuxomatic 'tmuxomatic/helios-development-infrastructure'
    repository 'git@gitlab.upc.biz:helios/development-infrastructure'
    email 'phalliday@libertyglobal.com'
  end
  project 'helios/jira-project-analysis' do
    user new_resource.user
    cookbook 'helios'
    tmuxomatic 'tmuxomatic/helios-jira-project-analysis'
    repository 'git@gitlab.upc.biz:helios/jira-project-analysis.git'
    email 'phalliday@libertyglobal.com'
  end
  project 'helios/local-dev-vm-setup' do
    user new_resource.user
    cookbook 'helios'
    tmuxomatic 'tmuxomatic/helios-local-dev-vm-setup'
    repository 'git@gitlab.upc.biz:helios/local-dev-vm-setup.git'
    email 'phalliday@libertyglobal.com'
  end

  # dummy project for VM mount point
  project 'helios/vm' do
    user new_resource.user
  end
end
