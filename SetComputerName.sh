#!/bin/sh

# script name SetComputerName.sh
# Last edit mkerr 2023.03.21

# default prefix is none is given
name_prefx="PREFIX-"

# Get the prefix form Jamf Pro Paramater 4 if provided
name_prefx="$4"

# full serialnumber
comp_SN=$(/usr/sbin/system_profiler SPHardwareDataType | awk '/Serial Number \(system/ {print $4}')

# Select just the last 7 digits of the SN, useful for AD binding to keep name at or below 14 char
# comp_SN=$(/usr/sbin/system_profiler SPHardwareDataType | awk '/Serial Number \(system/ {print $4}' | tail -c 8)


MachineName="$name_prefx""$comp_SN"

/usr/local/bin/jamf setComputerName -name "$MachineName"

# If you aren't using Jmaf Pro you can use the following
# scutil --set ComputerName "$MachineName"
# scutil --set HostName "$MachineName"
# scutil --set LocalHostName "$MachineName"

# this info will appear in the log for the policy that runs it.
scutil --get ComputerName
scutil --get HostName
scutil --get LocalHostName

# update the machine inventory in Jamf Pro to reflect the name change
/usr/local/bin/jamf recon

exit 0