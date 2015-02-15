def whyrun_supported?
  true
end

use_inline_resources

action :add do
  home = ::Dir.home(new_resource.user)
  group = ::Etc.getpwnam(new_resource.user).gid
  vim_dir = "#{home}/.vim"
  vim_config = "#{vim_dir}/config.vim"
  vim_config_dir = "#{vim_dir}/config"
  config = "#{vim_config_dir}/#{new_resource.name}.vim"
  directory vim_dir do
    owner new_resource.user
    group group
    mode 0755
  end
  directory vim_config_dir do
    owner new_resource.user
    group group
    mode 0755
  end
  source_config = "source #{config}"
  if ::File.file? vim_config
    fileEdit = Chef::Util::FileEdit.new(vim_config)
    fileEdit.insert_line_if_no_match(/#{Regexp.escape(source_config)}/, source_config)
    fileEdit.write_file
    new_resource.updated_by_last_action(new_resource.updated_by_last_action? || fileEdit.file_edited?)
  else
    file vim_config do
      content source_config
      owner new_resource.user
      group group
      mode 0644
    end
  end
  cookbook_file config do
    cookbook new_resource.cookbook
    source new_resource.source
    owner new_resource.user
    group group
    mode 0644
  end
end
