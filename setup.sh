#!/usr/bin/env bash
set -eu

bold=$(tput bold)
normal=$(tput sgr0)

function run {
  echo "${bold}> $@${normal}"
  "$@"
  echo ""
}

: "Install prerequirements" && {
  run brew cask install vagrant vmware-fusion vagrant-vmware-utility
}

: "Install vagrant-vmware-desktop plugin" && {
  vagrant plugin list | grep vagrant-vmware-desktop > /dev/null || {
    run vagrant plugin install vagrant-vmware-desktop
  }
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
