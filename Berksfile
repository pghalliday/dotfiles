source "https://supermarket.chef.io"

# use fixed version of homebrew recipe until fix is merged
cookbook 'homebrew', git: 'https://github.com/pghalliday-cookbooks/homebrew.git'

Dir['./cookbooks/*'].each do |path|
  cookbook(File.basename(path), path: path)
end
