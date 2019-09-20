
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

export CODE_DIRECTORY=~/code/sage

alias doclog='function __doclog() { `aws ecr get-login --no-include-email --profile=qa`; docker login; }; __doclog'
alias squash='function __squash() { git reset --soft HEAD~$(git rev-list master.. --count) && git commit -m "$1" && git push -f; }; __squash'
alias new_branch='function __new_branch() { git stash && git checkout master && git pull --rebase && git checkout -b "$1"; }; __new_branch'
alias delete_branch='function __delete_branch() { git push origin --delete $1 && git branch -D $1; }; __delete_branch'
alias release_candidate='function __release_candidate() { git stash && git checkout master && git pull --rebase && git checkout -b release-candidate && ./script/generate_release_notes.sh $1 && git add . && git commit -m "release $1" && git push; }; __release_candidate' 
alias switch_branch='function __switch_branch() { git stash && git checkout master && git pull --rebase && git checkout $1; }; __switch_branch' 
alias current_branch='function __current_branch() { git rev-parse --abbrev-ref HEAD; }; __current_branch'
alias recreate_build='function __recreate_build() { branch=$(current_branch); delete_branch build-$branch && create_build; }; __recreate_build'
alias create_build='function __create_build() { branch=$(current_branch); git checkout -b build-$branch && git push --set-upstream origin build-$branch && git checkout $branch; }; __create_build'


source ~/.bashrc
. /usr/local/etc/profile.d/z.sh

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/peter.grainger/.sdkman"
[[ -s "/Users/peter.grainger/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/peter.grainger/.sdkman/bin/sdkman-init.sh"
