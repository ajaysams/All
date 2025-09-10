#!/bin/bash

rm -f $0
clear
apt update
apt install curl -y
apt install wget -y
apt install jq -y

NC='\033[0m'
rbg='\033[41;37m'
r='\033[1;91m'
g='\033[1;92m'
y='\033[1;93m'
u='\033[0;35m'
c='\033[0;96m'
w='\033[1;97m'

if [ "${EUID}" -ne 0 ]; then
echo "${r}You need to run this script as root${NC}"
sleep 2
exit 0
fi
apt-get -y --purge remove apache2* >/dev/null 2>&1
if [[ ! -f /root/.isp ]]; then
curl -sS ipinfo.io/org?token=7a814b6263b02c > /root/.isp
fi
if [[ ! -f /root/.city ]]; then
curl -sS ipinfo.io/city?token=7a814b6263b02c > /root/.city
fi
if [[ ! -f /root/.myip ]]; then
curl -sS ipv4.icanhazip.com > /root/.myip
fi

export IP=$(cat /root/.myip);
export ISP=$(cat /root/.isp);
export CITY=$(cat /root/.city);
source /etc/os-release

function lane_atas() {
echo -e "${c}┌──────────────────────────────────────────┐${NC}"
}
function lane_bawah() {
echo -e "${c}└──────────────────────────────────────────┘${NC}"
}

data_server=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
date_list=$(date +"%Y-%m-%d" -d "$data_server")
url_izin="https://raw.githubusercontent.com/ajaysams/Izin/main/ip"  
client=$(curl -sS $url_izin | grep $IP | awk '{print $2}')
exp=$(curl -sS $url_izin | grep $IP | awk '{print $3}')
today=`date -d "0 days" +"%Y-%m-%d"`
time=$(printf '%(%H:%M:%S)T')
date=$(date +'%d-%m-%Y')
d1=$(date -d "$exp" +%s)
d2=$(date -d "$today" +%s)
certifacate=$(((d1 - d2) / 86400))
checking_sc() {
  useexp=$(curl -s $url_izin | grep $IP | awk '{print $3}')
  if [[ $date_list < $useexp ]]; then
    echo -ne
  else
    clear
    echo -e "\033[96m============================================\033[0m"
    echo -e "\033[44;37m           NotAllowed Autoscript         \033[0m"    
    echo -e "\033[96m============================================\033[0m"
    echo -e "\e[95;1m buy / rent AutoScript installer VPS Whatsapp wa.me/254778216971 \e[0m"
    echo -e "\033[96m============================================\033[0m"
    echo -e "\e[96;1m   1 IP        : ksh 100   \e[0m"
    echo -e "\e[96;1m   7 IP        : ksh 300   \e[0m"
    echo -e "\e[96;1m   Unli IP     : ksh 600   \e[0m"
    echo -e "\e[97;1m   open source : ksh 3000   \e[0m"
    echo -e ""
    echo -e "\033[96m============================================\033[0m"
    exit 0
  fi
}
checking_sc

clear

function ARCHITECTURE() {
if [[ "$( uname -m | awk '{print $1}' )" == "x86_64" ]]; then
    echo -ne
else
    echo -e "${r} Your Architecture Is Not Supported ( ${y}$( uname -m )${NC} )"
    exit 1
fi

if [[ ${ID} == "ubuntu" || ${ID} == "debian" ]]; then
    echo -ne
else
    echo -e " ${r}This Script only Support for OS"
    echo -e ""
    echo -e " - ${y}Ubuntu 20.04${NC}"
    echo -e " - ${y}Ubuntu 21.04${NC}"
    echo -e " - ${y}Ubuntu 22.04${NC}"
    echo -e " - ${y}Ubuntu 23.04${NC}"
    echo -e " - ${y}Ubuntu 24.04${NC}"
    echo ""
    echo -e " - ${y}Debian 10${NC}"
    echo -e " - ${y}Debian 11${NC}"
    echo -e " - ${y}Debian 12${NC}"
    Credit_Sc
    exit 0
fi

if [[ ${VERSION_ID} == "10" || ${VERSION_ID} == "11" || ${VERSION_ID} == "12" || ${VERSION_ID} == "20.04" || ${VERSION_ID} == "21.04" || ${VERSION_ID} == "22.04" || ${VERSION_ID} == "23.04" || ${VERSION_ID} == "24.04" ]]; then
    echo -ne
else
    echo -e " ${r}This Script only Support for OS"
    echo -e ""
    echo -e " - ${y}Ubuntu 20.04${NC}"
    echo -e " - ${y}Ubuntu 21.04${NC}"
    echo -e " - ${y}Ubuntu 22.04${NC}"
    echo -e " - ${y}Ubuntu 23.04${NC}"
    echo -e " - ${y}Ubuntu 24.04${NC}"
    echo ""
    echo -e " - ${y}Debian 10${NC}"
    echo -e " - ${y}Debian 11${NC}"
    echo -e " - ${y}Debian 12${NC}"
    Credit_Sc
    exit 0
fi

if [ "$(systemd-detect-virt)" == "openvz" ]; then
echo "OpenVZ is not supported"
exit 1
fi
}

# call
ARCHITECTURE

clear

function MakeDirectories() {
    # Main directories
    local main_dirs=(
        "/etc/xray" "/var/lib/LT" "/etc/lunatic" "/etc/limit"
        "/etc/vmess" "/etc/vless" "/etc/trojan" "/etc/ssh"
    )
    
    local lunatic_subdirs=("vmess" "vless" "trojan" "ssh" "bot")
    local lunatic_types=("usage" "ip" "detail")

    local protocols=("vmess" "vless" "trojan" "ssh")

    for dir in "${main_dirs[@]}"; do
        mkdir -p "$dir"
    done

    for service in "${lunatic_subdirs[@]}"; do
        for type in "${lunatic_types[@]}"; do
            mkdir -p "/etc/lunatic/$service/$type"
        done
    done

    for protocol in "${protocols[@]}"; do
        mkdir -p "/etc/limit/$protocol"
    done

    local databases=(
        "/etc/lunatic/vmess/.vmess.db"
        "/etc/lunatic/vless/.vless.db"
        "/etc/lunatic/trojan/.trojan.db"
        "/etc/lunatic/ssh/.ssh.db"
        "/etc/lunatic/bot/.bot.db"
    )

    for db in "${databases[@]}"; do
        touch "$db"
        echo "& plugin Account" >> "$db"
    done

    touch /etc/.{ssh,vmess,vless,trojan}.db
    echo "IP=" > /var/lib/LT/ipvps.conf
}

MakeDirectories

clear

function DOMAINS_MANAGER() {
    echo -e "\e[97;1m =========================== \e[0m"
    echo -e "\e[97;1m   DOMAIN CHANGES TO VPS    \e[0m"
    echo -e "\e[97;1m =========================== \e[0m"
    echo -e "\e[92;1m 1. Own domain \e[0m"
    echo -e "\e[92;1m 2. Random domain  \e[0m"
    echo -e "\e[97;1m =========================== \e[0m"
    echo -e ""
    read -p "Select choice domain 1-2: " DOMAINS_SELECT

    if [ "$DOMAINS_SELECT" == "1" ]; then
        clear
        echo -e "\e[97;1m =========================== \e[0m"
        echo -e "\e[96;1m      OWN DOMAIN        \e[0m"
        echo -e "\e[97;1m =========================== \e[0m"
        echo -e ""
        read -p "Your domains: " YUDOMAINS
        echo "$YUDOMAINS" > /etc/xray/domain
        echo "$YUDOMAINS" > /root/domain
    elif [ "$DOMAINS_SELECT" == "2" ]; then
        wget https://raw.githubusercontent.com/ajaysams/All/main/domains.sh \
             -O /tmp/domains.sh >/dev/null 2>&1 && \
             chmod +x /tmp/domains.sh && /tmp/domains.sh
    else
        echo -e "\e[91;1mInvalid choice!\e[0m"
    fi
    clear
}

DOMAINS_MANAGER

clear
function Installasi(){
animation_loading() {
    CMD[0]="$1"
    CMD[1]="$2"
    
    (
        # Remove fim file if exists
        [[ -e $HOME/fim ]] && rm -f $HOME/fim
        
        # Run command in background and hide output
        ${CMD[0]} -y >/dev/null 2>&1
        ${CMD[1]} -y >/dev/null 2>&1
        
        # Create fim file to mark completion
        touch $HOME/fim
    ) >/dev/null 2>&1 &

    tput civis # Hide cursor
    echo -ne "  \033[0;32mProcess\033[1;37m- \033[0;33m["
    
    while true; do
        for ((i = 0; i < 18; i++)); do
            echo -ne "\033[97;1m#"
            sleep 0.1
        done
        
        # If fim file exists, remove and exit loop
        if [[ -e $HOME/fim ]]; then
            rm -f $HOME/fim
            break
        fi
        
        echo -e "\033[0;31m]"
        sleep 1
        tput cuu1 # Return to previous line
        tput dl1   # Delete previous line
        echo -ne "  \033[0;32mProcess\033[1;37m- \033[0;31m["
    done
    
    echo -e "\033[0;31m]\033[1;37m -\033[1;32m OK!\033[0m"
    tput cnorm # Show cursor again
}

INSTALL_WEBSOCKET() {
wget https://raw.githubusercontent.com/ajaysams/All/main/ws/install-ws.sh && chmod +x install-ws.sh && ./install-ws.sh
wget https://raw.githubusercontent.com/ajaysams/All/main/ws/banner_ssh.sh && chmod +x banner_ssh.sh && ./banner_ssh.sh
}

INSTALL_BACKUP() {
apt install rclone
printf "q\n" | rclone config
wget -O /root/.config/rclone/rclone.conf "https://github.com/ajaysams/All/raw/main/rclone.conf"
git clone https://github.com/murahtunnel/wondershaper.git
cd wondershaper
make install
cd
rm -rf wondershaper
    
rm -f /root/set-br.sh
rm -f /root/limit.sh
}

INSTALL_OHP() {
wget https://raw.githubusercontent.com/ajaysams/All/main/ws/ohp.sh && chmod +x ohp.sh && ./ohp.sh
}

INSTALL_FEATURE() {
wget https://raw.githubusercontent.com/ajaysams/All/main/menu/install_menu.sh && chmod +x install_menu.sh && ./install_menu.sh
}

INSTALL_UDP_CUSTOM() {
wget https://raw.githubusercontent.com/ajaysams/All/main/ws/udp && chmod +x UDP.sh && ./UDP.sh
}

if [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "ubuntu" ]]; then
echo -e "\033[96;1mSETUP OS : $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')\e[0m"
UNTUK_UBUNTU
elif [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "debian" ]]; then
echo -e "\033[96;1mSETUP OS : $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')\e[0m"
UNTUK_DEBIAN
else
echo -e " Your OS Is Not Supported ( ${YELLOW}$(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')${FONT} )"
fi
}

function UNTUK_DEBIAN(){

#lane_atas
#echo -e "${c}│      ${g}PROCESS INSTALLED SSH & OPENVPN${NC}     ${c}│${NC}"
#lane_bawah
#animation_loading 'INSTALL_SSH'

#lane_atas
#echo -e "${c}│           ${g}PROCESS INSTALLED XRAY${NC}         ${c}│${NC}"
#lane_bawah
#animation_loading 'INSTALL_XRAY'

lane_atas
echo -e "${c}│       ${g}INSTALLING WEBSOCKET SSH${NC}    ${c}│${NC}"
lane_bawah
animation_loading 'INSTALL_WEBSOCKET'

lane_atas
echo -e "${c}│       ${g}INSTALLING BACKUP MENU${NC}${c}      │${NC}"
lane_bawah
animation_loading 'INSTALL_BACKUP'

lane_atas
echo -e "${c}│           ${g}INSTALLING OHP${NC}${c}          │${NC}"
lane_bawah
animation_loading 'INSTALL_OHP'

lane_atas
echo -e "${c}│           ${g}DOWNLOADING EXTRA MENU${NC}${c}            │${NC}"
lane_bawah
animation_loading 'INSTALL_FEATURE'

lane_atas
echo -e "${c}│           ${g}DOWNLOADING UDP CUSTOM${NC}${c}            │${NC}"
lane_bawah
animation_loading 'INSTALL_UDP_CUSTOM'

}

function UNTUK_UBUNTU(){

#lane_atas
#echo -e "${c}│      ${g}PROCESS INSTALLED SSH & OPENVPN${NC}     ${c}│${NC}"
#lane_bawah
#animation_loading 'INSTALL_SSH'

#lane_atas
#echo -e "${c}│           ${g}PROCESS INSTALLED XRAY${NC}         ${c}│${NC}"
#lane_bawah
#animation_loading 'INSTALL_XRAY'

lane_atas
echo -e "${c}│       ${g}INSTALLING WEBSOCKET SSH${NC}    ${c}│${NC}"
lane_bawah
animation_loading 'INSTALL_WEBSOCKET'

lane_atas
echo -e "${c}│       ${g}INSTALLING BACKUP MENU${NC}${c}      │${NC}"
lane_bawah
animation_loading 'INSTALL_BACKUP'

lane_atas
echo -e "${c}│           ${g}INSTALLING OHP${NC}${c}          │${NC}"
lane_bawah
animation_loading 'INSTALL_OHP'

lane_atas
echo -e "${c}│           ${g}DOWNLOADING EXTRA MENU${NC}${c}            │${NC}"
lane_bawah
animation_loading 'INSTALL_FEATURE'

lane_atas
echo -e "${c}│           ${g}DOWNLOADING UDP CUSTOM${NC}${c}            │${NC}"
lane_bawah
animation_loading 'INSTALL_UDP_CUSTOM'

}

# Set new desired value for fs.file-max
NEW_FILE_MAX=65535  # Change according to your needs

# Additional values for netfilter configuration
NF_CONNTRACK_MAX="net.netfilter.nf_conntrack_max=262144"
NF_CONNTRACK_TIMEOUT="net.netfilter.nf_conntrack_tcp_timeout_time_wait=30"

# File to be edited
SYSCTL_CONF="/etc/sysctl.conf"

# Get current fs.file-max value
CURRENT_FILE_MAX=$(grep "^fs.file-max" "$SYSCTL_CONF" | awk '{print $3}' 2>/dev/null)

# Check if fs.file-max value is already correct
if [ "$CURRENT_FILE_MAX" != "$NEW_FILE_MAX" ]; then
    # Check if fs.file-max already exists in file
    if grep -q "^fs.file-max" "$SYSCTL_CONF"; then
        # If exists, change its value
        sed -i "s/^fs.file-max.*/fs.file-max = $NEW_FILE_MAX/" "$SYSCTL_CONF" >/dev/null 2>&1
    else
        # If doesn't exist, add new line
        echo "fs.file-max = $NEW_FILE_MAX" >> "$SYSCTL_CONF" 2>/dev/null
    fi
fi

# Check if net.netfilter.nf_conntrack_max already exists
if ! grep -q "^net.netfilter.nf_conntrack_max" "$SYSCTL_CONF"; then
    echo "$NF_CONNTRACK_MAX" >> "$SYSCTL_CONF" 2>/dev/null
fi

# Check if net.netfilter.nf_conntrack_tcp_timeout_time_wait already exists
if ! grep -q "^net.netfilter.nf_conntrack_tcp_timeout_time_wait" "$SYSCTL_CONF"; then
    echo "$NF_CONNTRACK_TIMEOUT" >> "$SYSCTL_CONF" 2>/dev/null
fi


# Apply changes
sysctl -p >/dev/null 2>&1

function install_crond(){
wget https://raw.githubusercontent.com/ajaysams/All/main/install_cron.sh && chmod +x install_cron.sh && ./install_cron.sh
clear
}


clear

# install tools.sh
echo -e "\e[91;1m ================================ \e[0m"
echo -e "\e[97;1m    INSTALLING PACKAGES MODULE   \e[0m"
echo -e "\e[91;1m ================================ \e[0m"
cd
wget https://raw.githubusercontent.com/ajaysams/All/main/PACKAGES/tools.sh && chmod +x tools.sh && ./tools.sh
wget -q -O /etc/port.txt "https://raw.githubusercontent.com/ajaysams/All/main/PACKAGES/port.txt"

clear
start=$(date +%s)
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
apt install git
apt install python -y >/dev/null 2>&1

clear
echo -e "\e[91;1m ================================ \e[0m"
echo -e "\e[97;1m   INSTALLING SSH-VPN.SH MODULE    \e[0m"
echo -e "\e[91;1m ================================ \e[0m"
# install vpn-ssh.sh
sudo apt install at -y >/dev/null 2>&1

wget https://raw.githubusercontent.com/ajaysams/All/main/ssh/ssh-vpn.sh && chmod +x ssh-vpn.sh && ./ssh-vpn.sh

# installer gotop
gotop_latest="$(curl -s https://api.github.com/repos/xxxserxxx/gotop/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"
gotop_link="https://github.com/xxxserxxx/gotop/releases/download/v$gotop_latest/gotop_v"$gotop_latest"_linux_amd64.deb"
curl -sL "$gotop_link" -o /tmp/gotop.deb
dpkg -i /tmp/gotop.deb
clear

clear
# install ins-xray.sh
echo -e "\e[91;1m ================================ \e[0m"
echo -e "\e[97;1m   INSTALLING INS-XRAY.SH MODULE   \e[0m"
echo -e "\e[91;1m ================================ \e[0m"
# install all xray requirements
wget https://raw.githubusercontent.com/ajaysams/All/main/xray/ins-xray.sh && chmod +x ins-xray.sh && ./ins-xray.sh
clear
# limit quota & service xray
wget https://raw.githubusercontent.com/ajaysams/All/main/Xbw_LIMIT/install.sh && chmod +x install.sh && ./install.sh
clear
# limit service ip xray
wget https://raw.githubusercontent.com/ajaysams/All/main/AUTOKILL_SERVICE/service.sh && chmod +x service.sh && ./service.sh
clear

# call function
Installasi
install_crond

# install cron.d
cat> /root/.profile << END
if [ "$BASH" ]; then
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi
fi
mesg n || true
clear
menu
END
chmod 644 /root/.profile
if [ -f "/root/log-install.txt" ]; then
rm /root/log-install.txt > /dev/null 2>&1
fi
if [ -f "/etc/afak.conf" ]; then
rm /etc/afak.conf > /dev/null 2>&1
fi
history -c
serverV=$( curl -sS https://raw.githubusercontent.com/ajaysams/All/main/versi  )
echo $serverV > /root/.versi
echo "00" > /home/daily_reboot
aureb=$(cat /home/daily_reboot)
b=11
if [ $aureb -gt $b ]
then
gg="PM"
else
gg="AM"
fi
cd

curl -sS ifconfig.me > /etc/myipvps
curl -s ipinfo.io/city?token=75082b4831f909 >> /etc/xray/city
curl -s ipinfo.io/org?token=75082b4831f909  | cut -d " " -f 2-10 >> /etc/xray/isp

rm -f /root/*.sh
rm -f /root/*.txt


function SENDER_NOTIFICATION() {
CHATID="7767810300"
KEY="8342573148:AAF3MM5NGdt5AMW6YMIg9erZJx1Ml-1m7z0"
URL="https://api.telegram.org/bot$KEY/sendMessage"
TEXT="
<code>= = = = = = = = = = = = =</code>
<b>   🧱 AUTOSCRIPT PREMIUM 🧱 </b>
<b>        Notifications       </b>
<code>= = = = = = = = = = = = =</code>
<b>Client  :</b> <code>$client</code>
<b>ISP     :</b> <code>$ISP</code>
<b>Country :</b> <code>$CITY</code>
<b>DATE    :</b> <code>$date</code>
<b>Time    :</b> <code>$time</code>
<b>Expired :</b> <code>$exp</code>
<code>= = = = = = = = = = = = =</code>
<b>        DARKANON TUNNELING     </b>
<code>= = = = = = = = = = = = =</code>"
curl -s --max-time 10 -X POST "$URL" \
-d "chat_id=$CHATID" \
-d "text=$TEXT" \
-d "parse_mode=HTML" \
-d "disable_web_page_preview=true" \
-d "reply_markup={\"inline_keyboard\":[[{\"text\":\" ʙᴜʏ ꜱᴄʀɪᴘᴛ \",\"url\":\"https://wa.me/+254778216971\"}]]}"

clear
}

rm ~/.bash_history
rm -f openvpn
rm -f key.pem
rm -f cert.pem

clear
echo -e "${c}┌────────────────────────────────────────────┐${NC}"
echo -e "${c}│  ${g}SCRIPT INSTALLATION COMPLETED..${NC}                  ${c}│${NC}"
echo -e "${c}└────────────────────────────────────────────┘${NC}"
echo  ""
echo -e "\e[92;1m Rebooting in 3 seconds.... \e[0m"

SENDER_NOTIFICATION

sleep 3

clear
# Langsung reboot
reboot
