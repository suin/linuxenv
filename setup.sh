#!/usr/bin/env bash
set -eu

function run {
  echo "$(tput bold)> $@$(tput sgr0)"
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
    read -p "$(tput bold)Please put vagrant-vmware-desktop license file to $(pwd)/license.lic, and press return key:$(tput sgr0)"
  done
  run vagrant plugin license vagrant-vmware-desktop ./license.lic
}

: "Information" && {
  echo "$(tput bold)Setup has been finished. You may run following commands in the next setp:$(tput sgr0)"
  echo ""
  echo "  vagrant up"
}
