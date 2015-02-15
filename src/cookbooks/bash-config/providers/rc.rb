def whyrun_supported?
  true
end

use_inline_resources

action :add do
  bashrc = "#{new_resource.home}/.bashrc" 
  config_dir = "#{new_resource.home}/.bash-config"
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
      group new_resource.group
      mode 0644
    end
  end
  directory config_dir do
    owner new_resource.user
    group new_resource.group
    mode 0755
  end
  directory bashrcd do
    owner new_resource.user
    group new_resource.group
    mode 0755
  end
  cookbook_file bashrcdsh do
    cookbook new_resource.cookbook
    source new_resource.source
    owner new_resource.user
    group new_resource.group
    mode 0644
  end
end
