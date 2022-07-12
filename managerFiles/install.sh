#!/bin/bash
source "$(realpath "$0" | sed 's|\(.*\)/.*|\1|')/secrets.sh"

# Uses a wrapper to be able to store all packages for a project.
function install() {
    echo $1
    case $1 in
        -r | repository )
            save_package $2 "install/linux-repos.txt"
            sudo add-apt-repository $2
        ;;

        -s | system )
            save_package $2 "install/system.txt"
            sudo apt-get install $2
        ;;

        -n | node )
            yarn add $2
        ;;

        -p | python )
            save_package $2 "install/requirements.txt"
            pip3 install $2
        ;;
        
        -g | git )
            git submodule add https://github.com/$gitUser/$2.git
            cd $2 && git checkout master
        ;;
    esac
}

# Adds package to text file
function save_package(){
    echo $1 >> $2;
}
