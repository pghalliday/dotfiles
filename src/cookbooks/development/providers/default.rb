def whyrun_supported?
  true
end

use_inline_resources

action :add do
  home = ::Dir.home(new_resource.user)
  group = ::Etc.getpwnam(new_resource.user).gid
  development = "#{home}/development"
  directory development do
    owner new_resource.user
    group group
    mode 0755
  end
  project "development/spikes" do
    user new_resource.user
    cookbook 'development'
    tmuxomatic "tmuxomatic/spikes"
  end
  %w{
    dotfiles
    grunt-mocha-test
    jira-project-analysis
    shiny-jira-project-analysis
    tasks
  }.each do |name|
    project "development/#{name}" do
      user new_resource.user
      cookbook 'development'
      tmuxomatic "tmuxomatic/#{name}"
      repository "git@github.com:pghalliday/#{name}.git"
    end
  end
end
