def whyrun_supported?
  true
end

use_inline_resources

action :add do
  user = new_resource.user
  home = ::Dir.home(user)
  group = ::Etc.getpwnam(user).gid
  # local-dev-vm-setup configuration
  local_dev_vm_setup_dir = "#{home}/.local-dev-vm-setup"
  local_dev_vm_setup_config = "#{local_dev_vm_setup_dir}/config.json"
  directory local_dev_vm_setup_dir do
    owner user
    group group
    mode 0755
  end
  cookbook_file local_dev_vm_setup_config do
    source 'config.json'
    cookbook 'helios'
    owner user
    group group
    mode 0644
  end
  bash_alias 'h-mount' do
    user user
    command 'sudo mount -t nfs -o proto=tcp,port=2049 192.168.50.3:/helios ~/projects/helios/vm'
  end
  bash_alias 'h-umount' do
    user user
    command 'sudo umount ~/projects/helios/vm'
  end
  bash_alias 'h-ssh' do
    user user
    command 'ssh heliosdev@192.168.50.3'
  end
  bash_alias 'h-cd' do
    user user
    command 'cd ~/projects/helios/vm'
  end
  bash_alias 'helios-release-analysis' do
    user user
    command 'git-jira-utils-release-analysis "development" "origin/release/" "HS_[0-9]+\\.[0-9]+\\.[0-9]+" "\\.[a-z]"'
  end
  bash_alias 'helios-release-branch-commits' do
    user user
    command 'echo JIRA Password for phalliday:; read -s password; git-jira-utils-branch-commits origin/release/$1 development phalliday "$password" jira.upc.biz https HEL-[0-9]*'
    arg_offset 1
  end
  bash_alias 'helios-release-diff-commits' do
    user user
    command 'echo JIRA Password for phalliday:; read -s password; git-jira-utils-diff-commits origin/release/$1 development phalliday "$password" jira.upc.biz https HEL-[0-9]*'
    arg_offset 1
  end
  tmuxomatic 'helios-application-framework' do
    user user
    cookbook 'helios'
    source 'tmuxomatic/helios-application-framework'
  end
  project 'helios/development-infrastructure' do
    user user
    cookbook 'helios'
    tmuxomatic 'tmuxomatic/helios-development-infrastructure'
    repository 'git@gitlab.upc.biz:helios/development-infrastructure'
    email 'phalliday@libertyglobal.com'
  end
  project 'helios/jira-project-analysis' do
    user user
    cookbook 'helios'
    tmuxomatic 'tmuxomatic/helios-jira-project-analysis'
    repository 'git@gitlab.upc.biz:helios/jira-project-analysis.git'
    email 'phalliday@libertyglobal.com'
  end
  project 'helios/local-dev-vm-setup' do
    user user
    cookbook 'helios'
    tmuxomatic 'tmuxomatic/helios-local-dev-vm-setup'
    repository 'git@gitlab.upc.biz:helios/local-dev-vm-setup.git'
    email 'phalliday@libertyglobal.com'
  end

  # dummy project for VM mount point
  project 'helios/vm' do
    user user
  end
end
