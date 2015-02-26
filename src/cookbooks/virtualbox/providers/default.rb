def whyrun_supported?
  true
end

use_inline_resources

action :add do
  group "vboxusers" do
    action :modify
    members new_resource.user
    append true
  end
end
