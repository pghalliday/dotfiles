def whyrun_supported?
  true
end

use_inline_resources

action :add do
  bash_rc 'android-sdk' do
    user new_resource.user
    cookbook 'android-sdk'
    template 'rc.sh.erb'
    variables(
      home: ::File.join(node['android-sdk']['install_dir'], 'current')
    )
  end
end
