def whyrun_supported?
  true
end

use_inline_resources

action :add do
  git_config 'diff.tool' do
    user new_resource.user
    value 'p4merge'
  end
  git_config 'merge.tool' do
    user new_resource.user
    value 'p4merge'
  end
end
