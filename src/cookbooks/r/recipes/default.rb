apt_repository 'r' do
  uri 'http://cran-mirror.cs.uu.nl/bin/linux/ubuntu'
  distribution "#{node['lsb']['codename']}/"
  keyserver 'hkp://keyserver.ubuntu.com:80'
  key 'E084DAB9'
end
package 'r-base'
package 'r-base-dev'
