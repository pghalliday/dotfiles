workstation_user = node['workstation']['user']
workstation_aws_s3_bucket = node['workstation']['aws_s3_bucket']
workstation_aws_access_key_id = node['workstation']['aws_access_key_id']
workstation_aws_secret_access_key = node['workstation']['aws_secret_access_key']

workstation_cookbook = run_context.cookbook_collection[cookbook_name]
workstation_cookbook_files = workstation_cookbook.manifest['files']

# make sure apt repository  is up to date
include_recipe 'apt::default'

# setup ssh and keys
include_recipe 'ssh::default'
ssh workstation_user do
  aws_s3_bucket workstation_aws_s3_bucket
  aws_access_key_id workstation_aws_access_key_id
  aws_secret_access_key workstation_aws_secret_access_key
end

# setup desktop theme and icons
include_recipe 'theme::default'
theme workstation_user

# install curl
package 'curl'

# install bmon
package 'bmon'

# install nfs client stuff
package 'nfs-common'

# install inotify-tools
package 'inotify-tools'

# install xclip
package 'xclip'

# install bash
include_recipe 'bash'
bash_init workstation_user

# install git
include_recipe 'git::default'
git_init workstation_user do
  user_name 'Peter Halliday'
end

# install meld
include_recipe 'meld::default'
# use meld as default git diff tool
meld_init workstation_user

# install ruby
include_recipe 'ruby::default'

# install chefdk
include_recipe 'chefdk::default'
chefdk workstation_user

# install nodejs
include_recipe 'nodejs::default'

# install java
include_recipe 'java::default'
java workstation_user

# install python
include_recipe 'python::default'

# install AWS tools
include_recipe 'aws::default'
aws workstation_user

# install R
include_recipe 'r::default'

# install rust
include_recipe 'rust::default'

# install android sdk
include_recipe 'android-sdk::default'
android_sdk workstation_user

# install android studio
include_recipe 'android-studio::default'
android_studio workstation_user

# install dropbox
include_recipe 'dropbox::default'

# install Filezilla
include_recipe 'filezilla::default'

# install keepass2 for password management
include_recipe 'keepass2::default'

# install vim
include_recipe 'vim::default'
vim workstation_user 
%w{
elzr/vim-json
scrooloose/nerdtree
tpope/vim-surround
kchmck/vim-coffee-script
mtscout6/vim-cjsx
ekalinin/Dockerfile.vim
vim-scripts/AutoComplPop
scrooloose/nerdcommenter
jistr/vim-nerdtree-tabs
rust-lang/rust.vim
cespare/vim-toml
groenewege/vim-less
nathanaelkane/vim-indent-guides
digitaltoad/vim-jade
maksimr/vim-jsbeautify
pangloss/vim-javascript
}.each do |plugin|
  vim_plugin plugin do
    user workstation_user
  end
end
syntastic workstation_user
vim_markdown workstation_user
base16_vim workstation_user

# install tmux
include_recipe 'tmux::default'
tmux workstation_user

# install tmuxomatic
include_recipe 'tmuxomatic::default'

# install tmuxinator
include_recipe 'tmuxinator::default'
tmuxinator_init workstation_user

# install snx
include_recipe 'snx::default'
workstation_cookbook_files.each do |entry|
  parent_directory = ::File.basename(::File.dirname(entry['path']))
  name = entry['name']
  if parent_directory.eql? 'snx'
    snx_config name do
      source "snx/#{name}"
      user workstation_user
    end
  end
end

# install base16-shell
base16_shell workstation_user

# install bash-git-prompt
bash_git_prompt workstation_user

# install minicom
include_recipe 'minicom::default'
minicom workstation_user

# install docker
include_recipe 'docker::default'
docker workstation_user

# install vagrant and plugins
include_recipe 'vagrant::default'
%w{
  vagrant-omnibus
  vagrant-berkshelf
  vagrant-aws
}.each do |vagrant_plugin_name|
  vagrant_plugin vagrant_plugin_name do
    user workstation_user
  end
end

# install virtualbox
include_recipe 'virtualbox::default'
virtualbox workstation_user

## install  vmware workstation
#node.override['vmware-workstation']['aws_s3_bucket'] = workstation_aws_s3_bucket
#node.override['vmware-workstation']['aws_access_key_id'] = workstation_aws_access_key_id
#node.override['vmware-workstation']['aws_secret_access_key'] = workstation_aws_secret_access_key
#include_recipe 'vmware-workstation::default'
## add the vmware workstation vagrant plugin
#vmware_workstation workstation_user do
  #aws_s3_bucket workstation_aws_s3_bucket
  #aws_access_key_id workstation_aws_access_key_id
  #aws_secret_access_key workstation_aws_secret_access_key
#end

# install skype
include_recipe 'skype::default'

# install chrome
include_recipe 'chrome::default'

# install gimp
include_recipe 'gimp::default'

# install blender
include_recipe 'blender::default'

# install remmina
include_recipe 'remmina::default'

# install vlc
include_recipe 'vlc::default'

# install plex
include_recipe 'plex::default'

# set up unity launcher favourites
gsettings 'com.canonical.Unity.Launcher' do
  user workstation_user
  key 'favorites'
  value [
    'application://gnome-terminal.desktop',
    'application://nautilus.desktop',
    'application://google-chrome.desktop',
    'application://gcalctool.desktop',
    'application://skype.desktop',
    'application://plexhometheater.desktop',
    'application://vlc.desktop',
    'application://keepass2.desktop',
    'application://virtualbox.desktop',
    'application://blender.desktop',
    'application://gimp.desktop',
    'application://filezilla.desktop',
    'application://ubuntu-software-center.desktop',
    'application://unity-control-center.desktop',
    'application://gnome-screenshot.desktop',
    'unity://expo-icon',
    'unity://devices',
    'unity://running-apps'
  ]
end

# set up development projects
development workstation_user

# set up libertyglobal projects
libertyglobal workstation_user

# set up Helios projects
helios workstation_user
