def whyrun_supported?
  true
end

use_inline_resources

action :add do
  home = ::Dir.home(new_resource.user)
  group = ::Etc.getpwnam(new_resource.user).gid
  bashrc = "#{home}/.bashrc" 
  config_dir = "#{home}/.bash-config"
  bashrcd = "#{config_dir}/bashrc.d" 
  bashrcdsh = "#{bashrcd}/#{new_resource.name}.sh" 
  do_not_edit_tag = '# GENERATED FROM BASH COOKBOOK - DO NOT EDIT'
  enable_bashrcd_lines = <<-EOH

#{do_not_edit_tag}
for file in ~/.bash-config/bashrc.d/*
do . $file
done
EOH
  if ::File.file? bashrc
    fileEdit = Chef::Util::FileEdit.new(bashrc)
    fileEdit.insert_line_if_no_match(/#{do_not_edit_tag}/, enable_bashrcd_lines)
    fileEdit.write_file
    new_resource.updated_by_last_action(new_resource.updated_by_last_action? || fileEdit.file_edited?)
  else
    file bashrc do
      content enable_bashrcd_lines
      owner new_resource.user
      group group
      mode 0644
    end
  end
  directory config_dir do
    owner new_resource.user
      group group
    mode 0755
  end
  directory bashrcd do
    owner new_resource.user
    group group
    mode 0755
  end
  if new_resource.source
    cookbook_file bashrcdsh do
      cookbook new_resource.cookbook
      source new_resource.source
      owner new_resource.user
      group group
      mode 0644
    end
  elsif new_resource.template
    template bashrcdsh do
      cookbook new_resource.cookbook
      source new_resource.template
      variables new_resource.variables
      owner new_resource.user
      group group
      mode 0644
    end
  elsif new_resource.remote_file
    remote_file bashrcdsh do
      source new_resource.remote_file
      checksum new_resource.checksum
      owner new_resource.user
      group group
      mode 0644
    end
  else
    Chef::Application.fatal!('bash_rc resource requires one of source or remote_file')
  end
end
