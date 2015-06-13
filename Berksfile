source "https://supermarket.chef.io"

# use fixed version of homebrew recipe until fix is merged
cookbook 'homebrew', git: 'https://github.com/kbruner/homebrew.git', branch: 'issue71'

Dir['./cookbooks/*'].each do |path|
  cookbook(File.basename(path), path: path)
end
