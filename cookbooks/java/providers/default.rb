def whyrun_supported?
  true
end

use_inline_resources

action :add do
  bash_rc 'java' do
    user new_resource.user
    cookbook 'java'
    source 'java.sh'
  end
end
