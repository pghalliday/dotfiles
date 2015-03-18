package 'apt-transport-https'
apt_repository 'docker' do
  uri 'https://get.docker.com/ubuntu'
  distribution 'docker'
  components ['main']
  keyserver 'hkp://keyserver.ubuntu.com:80'
  key '36A1D7869245C8950F966E92D8576A8BA88D21E9'
end
package 'lxc-docker'

remote_file '/usr/local/bin/docker-compose' do
  source 'https://github.com/docker/compose/releases/download/1.1.0/docker-compose-Linux-x86_64'
  checksum '2e2d87d3e6dc795821598cc71790a79e360068dbdee6a3cf6c55b6bfd856fd83'
  mode 0755
end

remote_file '/etc/bash_completion.d/docker-compose' do
  source 'https://raw.githubusercontent.com/docker/compose/1.1.0/contrib/completion/bash/docker-compose'
  checksum 'd8bf9f150faa46253ff49c41af734ac42496f2a69442578aa39f337f61181587'
  mode 0644
end
