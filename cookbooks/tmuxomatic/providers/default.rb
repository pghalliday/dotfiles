def whyrun_supported?
  true
end

use_inline_resources

action :add do
  home = ::Dir.home(new_resource.user)
  group = ::Etc.getpwnam(new_resource.user).gid
  tmuxomatic_dir = "#{home}/.tmuxomatic"
  tmuxomatic_config = "#{tmuxomatic_dir}/#{new_resource.name}"
  directory tmuxomatic_dir do
    owner new_resource.user
    group group
    mode 0755
  end
  cookbook_file tmuxomatic_config do
    cookbook new_resource.cookbook
    source new_resource.source
    owner new_resource.user
    group group
    mode 0644
  end
  bash_alias "tmux-#{new_resource.name}" do
    command "TERM=xterm-256color tmuxomatic #{tmuxomatic_config}"
    user new_resource.user
  end
end
