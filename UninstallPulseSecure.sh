#!/bin/bash

# 2023.05.08

# Array of everything in the non user space related to Pulse, Juniper or Ivanti.
removeGlobal=( \
	# Pulse client files
	"/Applications/Ivanti Secure Access.app" \
	"/Applications/Pulse Secure.app" \
	"/Library/Application Support/Pulse Secure" \
	"/Library/LaunchAgents/net.pulsesecure."* \
	"/Library/LaunchDaemons/net.pulsesecure."* \
	# Old Juniper client files
	"/Applications/Network Connect.app" \
	"/Library/Application Support/Juniper Networks" \
	"/Applications/Junos Pulse.app" \
	"/Library/LaunchDaemons/net.juniper.UninstallPulse.plist.org" \
)

# check for the files or directories and remove them only if they exist
for removeGlobal in "${removeGlobal[@]}" ; do
	if [ -e "$removeGlobal" ] ; then
		echo "Removing $removeGlobal"
		rm -rf "$removeGlobal"
	fi
done

# check in each user directory and remove prefs there
for folder in /Users/*; do
    user=$(basename "${folder}")
    # compare folder name against the array items

# list for files and directories that might be in user directories
removeUserFls=( \
	# User dir files
	"/Users/${user}/Library/Application Support/Pulse Secure" \
	"/Users/${user}/Library/Preferences/net.pulsesecure."* \
	"/Users/${user}/Library/LaunchAgents/net.pulsesecure."* \
	"/Users/${user}/Library/Logs/Pulse Secure" \
	# Old Juniper client files
	"/Users/${user}/Library/Application Support/Juniper Networks/SetupClient" \
	"/Users/${user}/Library/Application Support/Juniper Networks/HostChecker.app" \
	"/Users/${user}/Library/Logs/Juniper Networks" \
	)

# check for the files or directories and remove them only if they exist
	for removeUserFls in "${removeUserFls[@]}" ; do
		if [ -e "$removeUserFls" ] ; then
			echo "Removing $removeUserFls"
			rm -rf "$removeUserFls"
		fi
	done

done

# Check for and kill any Pulse processes. we didn't unload any launch damons so killing is next best thing
pids=$(/usr/bin/pgrep -f "Pulse")
if [[ -n $pids ]]; then
	for pid in "${pids[@]}"; do
		/bin/kill "$pid"
	done
fi
# Check for and kill any Ivanti processes. we didn't unload any launch damons so killing is next best thing
pids=$(/usr/bin/pgrep "Ivanti")
if [[ -n $pids ]]; then
	for pid in "${pids[@]}"; do
		/bin/kill "$pid"
	done
fi
