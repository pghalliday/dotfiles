def whyrun_supported?
  true
end

use_inline_resources

action :add do
  group "dialout" do
    action :modify
    members new_resource.user
    append true
  end
  bash_config_alias 'minicom.USB0' do
    command 'minicom -D /dev/ttyUSB0'
    user new_resource.user
  end
end
