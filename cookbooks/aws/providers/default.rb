def whyrun_supported?
  true
end

use_inline_resources

action :add do
  bash_rc 'aws' do
    user new_resource.user
    cookbook 'aws'
    source 'aws.sh'
  end
end
