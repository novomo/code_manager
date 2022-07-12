#!/bin/bash
source "$(realpath "$0" | sed 's|\(.*\)/.*|\1|')/secrets.sh"

function run_tests () {
    server = $1
    rmtuname = "root"
    currentFolder = $(realpath "$0" | sed 's|\(.*\)/.*|\1|')
    folderName="${dirname%"${dirname##*[!/]}"}"
    sshpass -p$rmtpasswrd ssh  -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $rmtuname@$server "grep '2015-12-19.*.install ' /var/log/dpkg.log | awk '{ print $4 }' | cut -d: -f1 | xargs sudo apt-get --yes purge"
    # SCP - copy the script file from Current Directory to Remote Server 
    sshpass -p$rmtpasswrd scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no  $rmtuname@$server:/home/$folderName $(dirname "$currentFolder") 
    # Take Rest for 5 Seconds
    sleep 5

    # SSH to remote Server  and Execute a Command [ Invoke the Script ] 
    sshpass -p$rmtpasswrd ssh   -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $rmtuname@$server "/home/$folderName/install/setup"
    sshpass -p$rmtpasswrd ssh   -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $rmtuname@$server "/home/$folderName/tests/runTests"

}