def whyrun_supported?
  true
end

use_inline_resources

action :add do
  bash "update android sdk package #{new_resource.package}" do
    code <<-EOH
      cd #{new_resource.android_home}
      (while :; do echo y; sleep 2; done) | tools/android update sdk -u -t #{new_resource.package}
      EOH
    not_if { ::File.exist?(new_resource.creates) }
  end
end
