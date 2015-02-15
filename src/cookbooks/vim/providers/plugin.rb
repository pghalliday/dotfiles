def whyrun_supported?
  true
end

use_inline_resources

action :add do
  vim_dir = "#{new_resource.home}/.vim"
  vim_bundle = "#{vim_dir}/bundle"
  name = ::File.basename(new_resource.github)
  plugin = "#{vim_bundle}/#{name}"
  repository = "https://github.com/#{new_resource.github}"
  directory vim_dir do
    owner new_resource.user
    group new_resource.group
    mode 0755
  end
  directory vim_bundle do
    owner new_resource.user
    group new_resource.group
    mode 0755
  end
  git plugin do
    repository repository
    user new_resource.user
    group new_resource.group
  end
end
