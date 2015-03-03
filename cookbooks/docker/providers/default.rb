def whyrun_supported?
  true
end

use_inline_resources

action :add do
  group "docker" do
    action :modify
    members new_resource.user
    append true
  end
end
