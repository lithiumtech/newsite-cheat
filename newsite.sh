#!/bin/bash
# svn new site script with site name input
# Your path to checkouts/plugins/custom
CUSTOMPATH=~/lithium/checkouts/plugins/custom/
# Your path to services-sdk
SSDK=~/dev/services-sdk/

# if you want to change colors, this lists their numerical codes and outputs the color
# for (( i = 0; i < 17; i++ )); do echo "$(tput setaf $i)This is ($i) $(tput sgr0)"; done
RED=`tput setaf 1`
GREEN=`tput setaf 2`
BLUE=`tput setaf 14`
PINK=`tput setaf 13`
NC=`tput sgr0` #no color / reset
BLINK=`tput blink`

# VARS
siteName=""
childName=""
nl=$'\n'

# REGEX
sitePattern="^([A-z0-9])+\/([A-z0-9])+$"


echo "${nl}${GREEN}New site name to download?" 
read -p "-- (If child directory name is different, use ${PINK}sitename/childname${NC} otherwise just single site name, ${PINK}arlo${NC}) ${BLINK}" siteName
#read -p "${GREEN}Is there a different secondary folder name, i.e., ${PINK}evinrude/brp${NC} instead of ${PINK}arlo/arlo${NC}? [y/n]" yn
        # case $yn in 
        # y|Y)  read -p "${GREEN}What is that folder name?" diffChild ;;
        # n|n) 
        # *) 
        # esac

        if [[ $siteName =~ $sitePattern ]]
        then
        # EXCEPTION PATTERN of gm/gmonstar
            echo "Creating file structure and updating $siteName"
            cd $CUSTOMPATH || exit
            parentName="${siteName%/*}"
            childName="${siteName##*/}"
            echo "$parentName and $childName"

            svn update --set-depth=immediates $parentName $parentName/$childName $parentName/$childName/stage
             svn update --set-depth=infinity $parentName/$childName/stage
             cd $parentName/$childName/stage || exit
        else
        
        # NORMAL PATTERN of arlo/arlo
            echo "Creating file structure and updating $siteName"
            cd $CUSTOMPATH || exit
            svn update --set-depth=immediates $siteName $sitename/$siteName $siteName/$siteName/stage
            svn update --set-depth=infinity $siteName/$siteName/stage
            cd $siteName/$siteName/stage || exit

        fi


ls
pwd


cd $SSDK || exit
pwd
echo -e "${GREEN}Starting SSDK config${NC}"	
gulp add-config