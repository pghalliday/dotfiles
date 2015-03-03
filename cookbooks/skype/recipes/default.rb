%w{
libqt4-dbus:i386
libqt4-network:i386
libqt4-xml:i386
libqtcore4:i386
libqtgui4:i386
libqtwebkit4:i386
libstdc++6:i386
libxext6:i386
libxss1:i386
libxv1:i386
libssl1.0.0:i386
libpulse0:i386
libasound2-plugins:i386
}.each do |package_name|
  package package_name
end
skype_deb = "#{Chef::Config[:file_cache_path]}/skype.deb"
remote_file skype_deb do
  source 'http://download.skype.com/linux/skype-ubuntu-precise_4.3.0.37-1_i386.deb'
  checksum 'd19769135c014f7bdcb0c71410fd27698081c1aa4c6bbe53ccdd38576f17febc'
end
package 'skype' do
  source skype_deb
  provider Chef::Provider::Package::Dpkg
end
