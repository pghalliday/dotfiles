def whyrun_supported?
  true
end

use_inline_resources

action :add do
  home = ::Dir.home(new_resource.user)
  group = ::Etc.getpwnam(new_resource.user).gid
  # create the bash alias but prevent recursion
  # with the force_system_command option
  bash_alias 'tmux' do
    command 'tmux -2'
    user new_resource.user
    force_system_command true
  end
  cookbook_file "#{home}/.tmux.conf" do
    cookbook 'tmux'
    source '.tmux.conf'
    owner new_resource.user
    group group
    mode 0644
  end
end
