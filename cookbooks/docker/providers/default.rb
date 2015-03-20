def whyrun_supported?
  true
end

use_inline_resources

action :add do
  group "docker" do
    action :modify
    members new_resource.user
    append true
  end
  bash_alias 'docker-kill-all' do
    user new_resource.user
    command 'docker kill $(docker ps -q)'
  end
  bash_alias 'docker-clean-containers' do
    user new_resource.user
    command 'printf "\n>>> Deleting stopped containers\n\n" && docker rm $(docker ps -a -q)'
  end
  bash_alias 'docker-clean-images' do
    user new_resource.user
    command 'printf "\n>>> Deleting untagged images\n\n" && docker rmi $(docker images -q -f dangling=true)'
  end
  bash_alias 'docker-clean' do
    user new_resource.user
    command 'docker-clean-containers || true && docker-clean-images'
  end
  bash_alias 'docker-purge' do
    user new_resource.user
    command 'printf "\n>>> Deleting all images\n\n" && docker rmi $(docker images -q)'
  end
end
