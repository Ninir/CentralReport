#!/bin/bash

# ------------------------------------------------------------
# CentralReport Unix/Linux bash installer
# Alpha version. Don't use in production environment!
# ------------------------------------------------------------
# https://github.com/miniche/CentralReport/
# ------------------------------------------------------------

# Importing scripts...
source bash/vars.sh
source bash/log.inc.sh
source bash/functions.inc.sh
source bash/macos.inc.sh
source bash/debian.inc.sh

# Modes: only "install" yet ("check" mode will be added soon)
ACTUAL_MODE=install

# We are ready to uninstall CentralReport. Log this and print the header.
logFile "-------------- Starting CentralReport installer  --------------"

logConsole "\033[44m\033[1;37m"
logConsole "  -------------- CentralReport installer --------------"
logConsole "\033[0;44m"
logConsole "  Welcome! This script will install CentralReport on your host."
logConsole "  If you want more details, please visit http://github.com/miniche/CentralReport."
logConsole " "
logConsole " When installing CentralReport, we may ask for your password. It will allow CentralReport to write files and directories such as the project binaries, logs, etc."
logConsole "\033[0m"

# In the future, it will be possible to have different modes.
if [ -n "$1" ]; then
    ACTUAL_MODE=$1
fi

# Python is mandatory for CentralReport
getPythonIsInstalled
if [ $? -ne 0 ]; then
    logError "Error! Python must be installed on your host to execute CentralReport."
    exit 1
fi

# Getting current OS to check if uninstall will works for this host
getOS

# Check the actual mode.
if [ "install" == ${ACTUAL_MODE} ]; then

    # Right now, it only works on MacOS.
    # Support for Linux distrib coming soon.
    if [ ${CURRENT_OS} != ${OS_MAC} ] && [ ${CURRENT_OS} != ${OS_DEBIAN} ]; then
        logError " "
        logError "ERROR"
        logError "The install is only designed for Mac OS, Debian and Ubuntu."
        logError "Support for other OS will come soon!"
    else

        logConsole " "
        logConsole "Install mode enabled"
        read -p "You will install CentralReport. Are you sure you want to continue (y/N): " RESP < /dev/tty

        # Are you sure to install CR ?
        checkYesNoAnswer ${RESP}
        if [ $? -eq 0 ]; then

            # It's an indev version. At each install, we delete everything.

            # O=no error / 1=one or more errors
            bit_error=0

            if [ ${CURRENT_OS} == ${OS_MAC} ]; then
                logInfo "Processing... CentralReport will be installed on this Mac."
                macos_install
                if [ $? -ne 0 ]; then
                    bit_error=1
                fi

            elif [ ${CURRENT_OS} == ${OS_DEBIAN} ]; then
                logInfo "Processing... CentralReport will be installed on this Linux."
                debian_install
                if [ $? -ne 0 ]; then
                    bit_error=1
                fi

            fi


            if [ ${bit_error} -eq 1 ]; then

                logError "Something went wrong when installing CentralReport!"
                logError "CentralReport isn't installed on this host."

            else

                # Displays the success text!
                logConsole "\033[1;32m"
                logConsole " "
                logInfo "CentralReport is now installed!"
                logInfo "For more options, you can edit the config file at /etc/centralreport.cfg"
                logConsole " "
                logInfo "More help at http://github.com/miniche/CentralReport"
                logInfo "Have fun!"
                logConsole " "
                logConsole "\033[0m"

            fi

        fi

    fi

else
    logError " "
    logError "ERROR!"
    logError "Unknown argument"
    logError "Use: install.sh [install]"
fi


# End of program
logConsole " "
logInfo " -- End of the program -- "
