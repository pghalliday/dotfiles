def whyrun_supported?
  true
end

use_inline_resources

action :add do
  user = new_resource.user
  gsettings 'set desktop theme' do
    schema 'org.gnome.desktop.interface'
    key 'gtk-theme'
    value 'Ambiance-Blackout-Flat-Blue'
    user user
  end
  gsettings 'set icon theme' do
    schema 'org.gnome.desktop.interface'
    key 'icon-theme'
    value 'Vibrancy-Dark-Blue'
    user user
  end
  gsettings 'set window theme' do
    schema 'org.gnome.desktop.wm.preferences'
    key 'theme'
    value 'Ambiance-Blackout-Flat-Blue'
    user user
  end
end
