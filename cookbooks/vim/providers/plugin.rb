def whyrun_supported?
  true
end

use_inline_resources

action :add do
  home = ::Dir.home(new_resource.user)
  group = ::Etc.getpwnam(new_resource.user).gid
  vim_dir = "#{home}/.vim"
  vim_bundle = "#{vim_dir}/bundle"
  name = ::File.basename(new_resource.github)
  plugin = "#{vim_bundle}/#{name}"
  repository = "https://github.com/#{new_resource.github}"
  directory vim_dir do
    owner new_resource.user
    group group
    mode 0755
  end
  directory vim_bundle do
    owner new_resource.user
    group group
    mode 0755
  end
  git plugin do
    repository repository
    user new_resource.user
    group group
  end
end
