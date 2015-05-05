package 'openjdk-8-jdk'

# workaround for broken java cacerts
bash 'install java cacerts' do
  code <<-EOH
  /var/lib/dpkg/info/ca-certificates-java.postinst configure
  EOH
  not_if { ::File.exist?('/etc/ssl/certs/java/cacerts') }
end
