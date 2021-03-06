#!/bin/bash

# ------------------------------------------------------------
# CentralReport Unix/Linux uninstaller
# Alpha version. Don't use in production environment!
# ------------------------------------------------------------
# https://github.com/miniche/CentralReport/
# ------------------------------------------------------------

# Importing some scripts
source bash/debian.inc.sh
source bash/functions.inc.sh
source bash/log.inc.sh
source bash/macos.inc.sh
source bash/vars.sh

# Getting current OS to check if uninstall will works for this host
getOS

# We are ready to uninstall CentralReport. Log this and print the header.
logFile "-------------- Starting CentralReport uninstaller  --------------"

logConsole "\033[44m\033[1;37m"
logConsole " "
logConsole "-------------- CentralReport uninstaller --------------"
logConsole " "
logConsole "Welcome! This script will uninstall CentralReport on your host."
logConsole "If you want more details, please visit http://github.com/miniche/CentralReport"
logConsole "\033[0m"

getPythonIsInstalled
if [ $? -ne 0 ]; then
    logError "Error! Python must be installed on your host to remove CentralReport."
    exit 1
fi

logConsole " "
read -p "You will uninstall CentralReport. Are you sure you want to continue (y/N)? " RESP < /dev/tty


# Are you sure to uninstall CR?
checkYesNoAnswer ${RESP}
if [ $? -eq 0 ]; then
    logConsole "Processing..."
    logConsole " "

    if [ ${CURRENT_OS} != ${OS_MAC} ] && [ ${CURRENT_OS} != ${OS_DEBIAN} ]; then
        logConsole " "
        logError "ERROR"
        logError "The uninstall is only designed for Mac OS and Debian"
        logError "Support for other OS will come soon!"

    else
        # 0 = no
        bit_error=0

        if [ ${CURRENT_OS} = ${OS_MAC} ]; then
            # Remove CR from this Mac
            macos_uninstall
            if [ $? -ne 0 ]; then
                bit_error=1
            fi

            # Remove sudo privileges
            sudo -k

        elif [ ${CURRENT_OS} = ${OS_DEBIAN} ]; then

            # Remove CR from this computer
            debian_uninstall
            if [ $? -ne 0 ]; then
                bit_error=1
            fi

        fi

        if [ ${bit_error} -eq 1 ]; then

            logError "Error uninstalling CentralReport!"
            logError "CentralReport may still be installed on this host"

        else
            # Ok, it's done !
            logConsole "\033[1;32m"
            logConsole " "
            logInfo "CentralReport might be deleted on your host."
            logInfo "It's sad, but you're welcome!"
            logConsole " "
            logInfo "PS: Thanks for your interest in CentralReport! One of the best ways you can help us improve CentralReport is to let us know about any problems you find with it."
            logInfo "You can find the developers at http://github.com/miniche/CentralReport"
            logInfo "Thanks!"
            logConsole "\033[0m"

        fi
    fi
fi

# End of program
logConsole " "
logInfo " -- End of the program -- "
