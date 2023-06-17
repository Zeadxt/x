#!/bin/bash
MYIP=$(curl -sS ipv4.icanhazip.com)
echo "Checking VPS"
#########################
# Color Validation
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White
UWhite='\033[4;37m'       # White

On_IPurple='\033[0;105m'  #
On_IRed='\033[0;101m'
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White
Yellow='\033[0;93'
NC='\e[0m'
# // Export Color & Information
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export LIGHT='\033[0;37m'
export NC='\033[0m'
# VPS Information
UDPCORE="https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1S3IE25v_fyUfCLslnujFBSBMNunDHDk2' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1S3IE25v_fyUfCLslnujFBSBMNunDHDk2"
#Domain
domain=$(cat /etc/xray/domain)
#Status certificate
modifyTime=$(stat $HOME/.acme.sh/${domain}_ecc/${domain}.key | sed -n '7,6p' | awk '{print $2" "$3" "$4" "$5}')
modifyTime1=$(date +%s -d "${modifyTime}")
currentTime=$(date +%s)
stampDiff=$(expr ${currentTime} - ${modifyTime1})
days=$(expr ${stampDiff} / 86400)
remainingDays=$(expr 90 - ${days})
tlsStatus=${remainingDays}
if [[ ${remainingDays} -le 0 ]]; then
	tlsStatus="expired"
fi
# OS Uptime
uptime="$(uptime -p | cut -d " " -f 2-10)"
# Download
# Getting CPU Information
ttoday="$(vnstat | grep today | awk '{print $8" "substr ($9, 1, 3)}' | head -1)"
tmon="$(vnstat -m | grep `date +%G-%m` | awk '{print $8" "substr ($9, 1 ,3)}' | head -1)"
cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
cpu_usage="$((${cpu_usage1/\.*} / ${corediilik:-1}))"
cpu_usage+=" %"
ISP=$(curl -s ipinfo.io/org?token=2e48a6d62556ca | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city?token=2e48a6d62556ca )
WKT=$(curl -s ipinfo.io/timezone?token=2e48a6d62556ca )
#os=$(curl-s "`hostnamectl | grep "Operating System" | cut -d ' ' -f5-`)
DAY=$(date +%A)
DATE=$(date +%m/%d/%Y)
DATE2=$(date -R | cut -d " " -f -5)
IPVPS=$(curl -s ipinfo.io/ip?token=2e48a6d62556ca )
cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
tram=$( free -m | awk 'NR==2 {print $2}' )
uram=$( free -m | awk 'NR==2 {print $3}' )
fram=$( free -m | awk 'NR==2 {print $4}' )

#KonZ
vlx=$(grep -c -E "^#vl# " "/etc/xray/config.json")
let vla=$vlx/2
vmc=$(grep -c -E "^#vm# " "/etc/xray/config.json")
let vma=$vmc/2
ssh1="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
trx=$(grep -c -E "^#tr# " "/etc/xray/config.json")
let tra=$trx/2
ssx=$(grep -c -E "^#ss# " "/etc/xray/config.json")
let ssa=$ssx/2

clear 
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[44;1;39m                    ⇱ SERVER INFORMATION ⇲                    \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "${BICyan} ⇲  ${BICyan}SCRIPT BY       :  ${Yellow}FREE TUNNELING PROJECT${NC}"    
echo -e "${BICyan} ⇲  ${BICyan}Current Domain  :  ${Yellow}$domain${NC}" 
echo -e "${BICyan} ⇲  ${BICyan}IP-VPS          :  ${Yellow}$IPVPS${NC}"                  
echo -e "${BICyan} ⇲  ${BICyan}ISP-VPS         :  ${Yellow}$ISP${NC}"
echo -e "${BICyan} ⇲  ${BICyan}DATE&TIME       :  ${Yellow}$( date -d "0 days" +"%d-%m-%Y | %X" ) ${NC}" 
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[44;1;39m                         ⇱ RUNNING ⇲                          \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "        ${green}Today : ${ttoday}                  month : ${tmon} ${NC}"
echo -e "${BICyan}│  \033[0m ${BOLD}${YELLOW}SSH     VMESS       VLESS      TROJAN       SHADOWSOCKS$NC ${BICyan} │"
echo -e "${BICyan}│  \033[0m ${BICyan} $ssh1        $vma           $vla          $tra              $ssa   $NC    ${BICyan} │"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[44;1;39m                     ⇱ MENU SERVICE ⇲                         \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e " ${BICyan}[${BIWhite}01${BICyan}]${RED} •${NC} ${CYAN}SSH MENU        $NC  ${BICyan}[${BIWhite}09${BICyan}]${RED} • ${NC}${CYAN}SPEEDTEST $NC"
echo -e " ${BICyan}[${BIWhite}02${BICyan}]${RED} •${NC} ${CYAN}VMESS MENU      $NC  ${BICyan}[${BIWhite}10${BICyan}]${RED} • ${NC}${CYAN}SET AUTO REBOOT $NC"
echo -e " ${BICyan}[${BIWhite}03${BICyan}]${RED} •${NC} ${CYAN}VLESS MENU      $NC  ${BICyan}[${BIWhite}11${BICyan}]${RED} • ${NC}${CYAN}RESTART ALL SERVICE $NC"
echo -e " ${BICyan}[${BIWhite}04${BICyan}]${RED} •${NC} ${CYAN}TROJAN MENU     $NC  ${BICyan}[${BIWhite}12${BICyan}]${RED} • ${NC}${CYAN}CEK BANDWIDTH $NC"
echo -e " ${BICyan}[${BIWhite}05${BICyan}]${RED} •${NC} ${CYAN}S-SOCK MENU     $NC  ${BICyan}[${BIWhite}13${BICyan}]${RED} • ${NC}${CYAN}INSTALL UDP SERVICE  $NC"
echo -e " ${BICyan}[${BIWhite}06${BICyan}]${RED} •${NC} ${CYAN}CEK RUNNING     $NC  ${BICyan}[${BIWhite}14${BICyan}]${RED} • ${NC}${CYAN}CERTV2RAY/ADD SSL $NC"
echo -e " ${BICyan}[${BIWhite}07${BICyan}]${RED} •${NC} ${CYAN}CLEAR CACHE     $NC  ${BICyan}[${BIWhite}15${BICyan}]${RED} • ${NC}${CYAN}CHANGE BANNER $NC"
echo -e " ${BICyan}[${BIWhite}08${BICyan}]${RED} •${NC} ${CYAN}MENU DOMAIN     $NC  ${BICyan}[${BIWhite}16${BICyan}]${RED} • ${NC}${CYAN}CHANGE PASSWORD $NC"
echo -e " ${BICyan}[${BIWhite}X ${BICyan}]${RED} •${NC} ${CYAN}TYPE X FOR EXIT $NC  ${BICyan}[${BIWhite}17${BICyan}]${RED} • ${NC}${CYAN}INSTALL TCP BBR $NC"  
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[44;1;39m                ⇱ DTA X ZEAKING PROJECT ⇲                     \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"

echo -e   ""
read -p " Select menu :  "  opt
echo -e   ""
case $opt in
1) clear ; m-sshovpn ;;
2) clear ; m-vmess ;;
3) clear ; m-vless ;;
4) clear ; m-trojan ;;
5) clear ; m-ssws ;;
6) clear ; running ;;
7) clear ; clearcache ;;
8) clear ; m-domain ;;
9) clear ; speedtest ;;
10) clear ; auto-reboot ;;
11) clear ; restart ;;
12) clear ; bw ;;
13) clear ; wget --load-cookies /tmp/cookies.txt ${UDPCORE} -O install-udp && rm -rf /tmp/cookies.txt && chmod +x install-udp && ./install-udp ;;
14) clear ; certv2ray ;;
15) clear ; nano /etc/issue.net ;;
16) clear ; passwd ;;
17) clear ; m-tcp ;;
x) exit ;;
*) echo "Masukkan Angka Yang Benar " ; sleep 1 ; menu ;;
esac
