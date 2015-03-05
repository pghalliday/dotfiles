def whyrun_supported?
  true
end

use_inline_resources

action :install do
  gem_package new_resource.name do
    gem_binary '/usr/bin/gem'
  end
end
