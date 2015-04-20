def whyrun_supported?
  true
end

use_inline_resources

action :add do
  project "spikes" do
    user new_resource.user
    cookbook 'development'
    tmuxomatic "tmuxomatic/spikes"
  end
  %w{
    dotfiles
    dotfiles-windows
    git-jira-utils
    tee-with-timestamp
    grunt-mocha-test
    jira-project-analysis
    atlassian-test
    atlassian-test-aws
    tmuxomatic
  }.each do |name|
    project "#{name}" do
      user new_resource.user
      repository "git@github.com:pghalliday/#{name}.git"
      email 'pghalliday@gmail.com'
    end
  end
  %w{
    shiny-jira-project-analysis
    tasks
    pghalliday.github.io
    atlassian-test-docker
  }.each do |name|
    project "#{name}" do
      user new_resource.user
      cookbook 'development'
      tmuxomatic "tmuxomatic/#{name}"
      repository "git@github.com:pghalliday/#{name}.git"
      email 'pghalliday@gmail.com'
    end
  end
  %w{
    crowd
    jira
    stash
    confluence
    bamboo
  }.each do |name|
    project "docker/#{name}" do
      user new_resource.user
      repository "git@github.com:pghalliday-docker/#{name}.git"
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
  bash_alias 'git-jira-utils-release-analysis' do
    user new_resource.user
    command '~/development/git-jira-utils/release-analysis.sh'
  end
end
