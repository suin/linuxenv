# this is for root account
# set -eu

: "Go to the directory which is same as the one of host machine if it is possible" && {
  function goto_dir {
    local -r HOST_CURRENT_WORKING_DIRECTORY_FILE=/vagrant/host-current-working-directory.cache
    [ -f ${HOST_CURRENT_WORKING_DIRECTORY_FILE} ] && {
      local -r HOST_CURRENT_WORKING_DIRECTORY=$(cat ${HOST_CURRENT_WORKING_DIRECTORY_FILE})
      [ -d ${HOST_CURRENT_WORKING_DIRECTORY} ] && {
        cd ${HOST_CURRENT_WORKING_DIRECTORY}
      }
    }
  }
  goto_dir
  unset -f goto_dir
}
