def whyrun_supported?
  true
end

use_inline_resources

action :add do
  home = ::Dir.home(new_resource.user)
  group = ::Etc.getpwnam(new_resource.user).gid
  projects_dir = ::File.join(home, 'projects')
  directory projects_dir do
    owner new_resource.user
    group group
  end
  dir = new_resource.directory
  path_components = dir.split(::File::SEPARATOR)
  dir = projects_dir
  path_components.each do |path_component|
    dir = ::File.join(dir, path_component)
    directory dir do
      owner new_resource.user
      group group
    end
  end
  tmuxomatic_name = path_components.join('_')
  if !new_resource.tmuxomatic.nil?
    tmuxomatic tmuxomatic_name do
      cookbook new_resource.cookbook
      source new_resource.tmuxomatic
      user new_resource.user
    end
  else
    tmuxomatic tmuxomatic_name do
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
