#!/bin/bash
source "$(realpath "$0" | sed 's|\(.*\)/.*|\1|')/secrets.sh"

function ceate_new_project() {
    repo=$1
    private=$2
    # create repo on github
    if [["$private" =~ ^([yY][eE][sS]|[yY])$]]; then    curl
        curl -H "Authorization: token $gitAccessToken" -d '{"name": "'"$repo"'", "auto_init": true, "private": true}' https://api.github.com/user/repos #this will create the repo in github.
    else
        curl -H "Authorization: token $gitAccessToken" -d '{"name": "'"$repo"'", "auto_init": true, "private": false}' https://api.github.com/user/repos
    fi

    # assign current working folder to constant
    currentFolder = $(realpath "$0" | sed 's|\(.*\)/.*|\1|')
    # Create and copy all needed files inrepo
    mkdir $repo 
    touch $repo/README.md
    mkdir $repo/tests
    cp $(dirname "$currentFolder")/runTests $repo/tests/runTests
    chmod +x $repo/tests/runTests
    mkdir $repo/src
    # Install files
    mkdir $repo/install
    cp $(dirname "$currentFolder")/install/setup
    chmod +x $repo/tests/runTests
    touch $repo/install/requirements.txt
    touch $repo/install/linux.txt
    touch $repo/install/system.txt
    cp $(dirname "$currentFolder")/.gitignore $repo/.gitignore
    # update files
    cp $(dirname "$currentFolder")/update/liveUpdatePull.sh $repo/update/liveUpdatePull.sh
    cp $(dirname "$currentFolder")/update/liveUpdateReinstall.sh $repo/update/liveUpdatePull.sh
    cp $(dirname "$currentFolder")/update/liveUpdateReboot.sh $repo/vupdate/liveUpdatePull.sh
    chmod +x $repo/update/liveUpdatePull.sh
    chmod +x $repo/update/liveUpdatePull.sh
    chmod +x $repo/vupdate/liveUpdatePull.sh
    # Initial Commit to repo
    cd $repo && git init
    git remote add origin git@github.com:$gitUser/$repo.git
    git add .
    git commit -m "feat: Initial commit of project structure, license, and readme."
    git push -u origin master
}