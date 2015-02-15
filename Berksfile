source "https://supermarket.chef.io"

Dir['./src/cookbooks/*'].each do |path|
  cookbook(File.basename(path), path: path)
end
