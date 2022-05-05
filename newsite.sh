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


read -p "${GREEN}New site name? ${NC}" sitename
echo "Creating file structure and updating $sitename"
cd $CUSTOMPATH || exit
svn update --set-depth=immediates $sitename $sitename/$sitename $sitename/$sitename/stage
svn update --set-depth=infinity $sitename/$sitename/stage
cd $sitename/$sitename/stage || exit
ls
pwd


cd $SSDK || exit
pwd
echo -e "${GREEN}Starting SSDK config${NC}"	
gulp add-config
