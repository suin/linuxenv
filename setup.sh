#!/usr/bin/env bash
set -eu

bold=$(tput bold)
normal=$(tput sgr0)

function run {
  echo "${bold}> $@${normal}"
  "$@"
  echo ""
}

function install_vagrant_plugin {
  vagrant plugin list | grep ${1} > /dev/null || {
    run vagrant plugin install ${1}
  }
}

: "Install prerequirements" && {
  run brew cask install vagrant vmware-fusion vagrant-vmware-utility
}

: "Install vagrant-fsevents plugin" && {
  install_vagrant_plugin vagrant-fsevents
}

: "Install vagrant-vmware-desktop plugin" && {
  install_vagrant_plugin vagrant-vmware-desktop
}

: "Activate vagrant-vmware-desktop plugin license" && {
  until [ -f ./license.lic ]
  do
    read -p "${bold}Please put vagrant-vmware-desktop license file to $(pwd)/license.lic, and press return key:${normal}"
  done
  run vagrant plugin license vagrant-vmware-desktop ./license.lic
}

: "Provision Linux VM" && {
  run vagrant up
}

: "Show tips" && {
  echo "${bold}Setup has been finished. I suggest adding the following configuration to your .bashrc to use 'linuxenv' command, by which you can log in to the Linux VM wherever you are:${normal}"
  echo ""
  echo "  export PATH=\$PATH:$(pwd)/bin"
}
