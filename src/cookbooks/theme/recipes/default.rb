apt_repository 'ravefinity-project' do
  uri 'ppa:ravefinity-project/ppa'
  distribution node['lsb']['codename']
end
package 'ambiance-blackout-flat-colors'
package 'vibrancy-colors'
package 'unity-tweak-tool'
