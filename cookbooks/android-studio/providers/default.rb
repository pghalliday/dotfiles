def whyrun_supported?
  true
end

use_inline_resources

action :add do
  bash_rc 'android-studio' do
    user new_resource.user
    cookbook 'android-studio'
    template 'rc.sh.erb'
    variables(
      bin: ::File.join(node['android-studio']['install_dir'], 'current', 'bin')
    )
  end
end
