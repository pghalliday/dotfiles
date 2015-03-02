def whyrun_supported?
  true
end

use_inline_resources

action :set do
  schema = new_resource.schema
  key = new_resource.key
  value = "'#{new_resource.value}'"
  user = new_resource.user
  gsettings_get_command = Mixlib::ShellOut.new(
    "gsettings get #{schema} #{key}",
    user: user
  )
  gsettings_get_command.run_command()
  gsettings_get_command.error!
  current_value = gsettings_get_command.stdout
  if (/^#{value}$/ =~ current_value).nil? 
    # get the DBUS_SESSION_BUS_ADDRESS in case the user is logged in
    # using this ensures that the setting gets applied immediately
    dbus_session_address_script  = <<-'EOH'
      pidof -s nautilus | while read pid; do tr '\0' '\n' < /proc/${pid}/environ | grep "DBUS_SESSION_BUS_ADDRESS="; done
    EOH
    dbus_session_address_command = Mixlib::ShellOut.new(
      dbus_session_address_script
    )
    dbus_session_address_command.run_command()
    dbus_session_address = dbus_session_address_command.stdout.strip
    gsettings_set_script = <<-EOH
      #{dbus_session_address} gsettings set #{schema} #{key} #{value}
    EOH
    bash "gsettings set #{schema} #{key}" do
      code gsettings_set_script
      user user
    end
  end
end
