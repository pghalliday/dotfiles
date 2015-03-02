def whyrun_supported?
  true
end

use_inline_resources

action :enable do
  home = ::Dir.home(new_resource.user)
  group = ::Etc.getpwnam(new_resource.user).gid
  bash_profile = "#{home}/.bash_profile" 
  enable_bash_profile_lines = <<-EOH

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
EOH
  if ::File.file? bash_profile
    fileEdit = Chef::Util::FileEdit.new(bash_profile)
    fileEdit.insert_line_if_no_match(/~\/.bashrc/, enable_bash_profile_lines)
    fileEdit.write_file
    new_resource.updated_by_last_action(new_resource.updated_by_last_action? || fileEdit.file_edited?)
  else
    file bash_profile do
      content enable_bash_profile_lines
      owner new_resource.user
      group group
      mode 0644
    end
  end
end
