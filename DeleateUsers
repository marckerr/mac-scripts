#!/bin/bash

####################
# This script will delete all local home directories
# *except* for those specified in the KEEPERS array.
####################

# define users to keep in an array, with spaces between items
# be sure to not remove the Shared folder
KEEPERS=( usernametokeep Shared )

# log the time the script starts.
date >> /var/log/removedusers.log

# iterate through list of folders in /Users
for folder in /Users/*; do
    user=$(basename "${folder}")
    # compare folder name against the array items
    if [[ "${KEEPERS[*]}" =~ ${user} ]]; then
        # skip if folder is in the skip array
        echo "Skipping ${user}..." >> /var/log/removedusers.log
    else
        # proceed with removal
        echo "Removing ${user}..." >> /var/log/removedusers.log
        # remove the users from the .local database also
        dscl . -delete "/Users/${user}"
        # now remove the home folder
        rm -rf "/Users/${user}"
    fi
done
exit 0
