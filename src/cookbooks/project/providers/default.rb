def whyrun_supported?
  true
end

use_inline_resources

action :add do
  home = ::Dir.home(new_resource.user)
  group = ::Etc.getpwnam(new_resource.user).gid
  dir = ::File.join(home, new_resource.directory)
  directory dir do
    owner new_resource.user
    group group
    mode 0755
  end
  if !new_resource.tmuxomatic.nil?
    tmuxomatic ::File.basename(new_resource.tmuxomatic) do
      cookbook new_resource.cookbook
      source new_resource.tmuxomatic
      user new_resource.user
    end
  end
  if !new_resource.repository.nil?
    git_status = Mixlib::ShellOut.new(
      "su -l #{new_resource.user} -c 'cd #{dir} && git status'"
    )
    git_status.run_command
    log git_status.error?
    if git_status.error?
      git_clone = Mixlib::ShellOut.new(
        "su -l #{new_resource.user} -c 'git clone #{new_resource.repository} #{dir}'"
      )
      git_clone.run_command
      git_clone.error!
      new_resource.updated_by_last_action(true)
    end
  end
end
