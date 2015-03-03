def whyrun_supported?
  true
end

use_inline_resources

def check_fingerprint(fingerprint, to_check)
  current_fingerprint_match = /^[0-9]* ([^\s]*)/.match(to_check)
  current_fingerprint = current_fingerprint_match[1] if !current_fingerprint_match.nil?
  return current_fingerprint.eql?(fingerprint)
end

def check_public_key(fingerprint, public_key)
  file = Tempfile.new('public_key')
  file.write(public_key)
  file.close
  get_fingerprint_command = Mixlib::ShellOut.new(
    "ssh-keygen -lf #{file.path}"
  )
  get_fingerprint_command.run_command
  file.unlink
  return !get_fingerprint_command.error? && check_fingerprint(fingerprint, get_fingerprint_command.stdout)
end

action :add do
  host = new_resource.host
  fingerprint = new_resource.fingerprint
  user = new_resource.user
  home = ::Dir.home(user)
  group = ::Etc.getpwnam(user).gid
  ssh_dir = "#{home}/.ssh"
  known_hosts = ::File.join(ssh_dir, 'known_hosts')
  directory ssh_dir do
    owner user
    group group
    mode 0700
  end
  file known_hosts do
    owner user
    group group
    mode 0644
    action :create_if_missing
  end
  host_known_command = Mixlib::ShellOut.new(
    "ssh-keygen -F #{host} -f #{known_hosts} -l",
    user: user
  )
  host_known_command.run_command
  add_host = true
  if !host_known_command.error?
    add_host = false
    # host is known let's check the fingerprint if we have it
    if !fingerprint.nil?
      fingerprint_ok = check_fingerprint(fingerprint, host_known_command.stdout)
      if !fingerprint_ok
        bash "delete known host #{host} with incorrect fingerprint" do
          code "ssh-keygen -R #{host}"
          user user
        end
        add_host = true
      end
    end
  end
  if add_host
    get_known_hosts_entry = Mixlib::ShellOut.new(
      "ssh-keyscan -H #{host}",
      user: user
    )
    get_known_hosts_entry.run_command
    get_known_hosts_entry.error!
    # check the fingerprint if we have it
    if !fingerprint.nil?
      fingerprint_ok = check_public_key(fingerprint, get_known_hosts_entry.stdout)
      Chef::Application.fatal!("fingerprint of ssh key for #{host} does not match") if !fingerprint_ok
    end
    bash "add known host #{host}" do
      code "echo '#{get_known_hosts_entry.stdout}' >> #{known_hosts}"
      user user
    end
  end
end
