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

  android_sdk_avd 'default' do
    user new_resource.user
    target 'Google Inc.:Google APIs:22'
    skin 'WXGA720'
    abi 'google_apis/x86_64'
  end
end
