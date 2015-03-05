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
  else
    tmuxomatic ::File.basename(dir) do
      directory dir
      user new_resource.user
    end
  end
  if !new_resource.repository.nil?
    git_clone new_resource.repository do
      user new_resource.user
      project_path dir
    end
    git_config 'user.email' do
      user new_resource.user
      project_path dir
      value new_resource.email
    end
  end
end
