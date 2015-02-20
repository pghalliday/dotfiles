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
    git-jira-utils
    tee-with-timestamp
    grunt-mocha-test
    jira-project-analysis
    shiny-jira-project-analysis
    tasks
    pghalliday.github.io
  }.each do |name|
    project "development/#{name}" do
      user new_resource.user
      cookbook 'development'
      tmuxomatic "tmuxomatic/#{name}"
      repository "git@github.com:pghalliday/#{name}.git"
      email 'pghalliday@gmail.com'
    end
  end
  bash_alias 'tee-with-timestamp' do
    user new_resource.user
    command '~/development/tee-with-timestamp/tee-with-timestamp.sh'
  end
  bash_alias 'git-jira-utils-branch-commits' do
    user new_resource.user
    command '~/development/git-jira-utils/branch-commits.sh'
  end
  bash_alias 'git-jira-utils-diff-commits' do
    user new_resource.user
    command '~/development/git-jira-utils/diff-commits.sh'
  end
end
