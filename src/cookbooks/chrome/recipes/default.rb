package 'libappindicator1'
chrome_deb = "#{Chef::Config[:file_cache_path]}/chrome.deb"
remote_file chrome_deb do
  source 'https://dl-ssl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'
  checksum '0a1f0a1ff5b4472430b69f48ab77bf9f535a5a87074d15410ea017d796831544'
end
package 'chrome' do
  source chrome_deb
  provider Chef::Provider::Package::Dpkg
end
