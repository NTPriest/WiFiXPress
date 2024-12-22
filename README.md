# **WiFiXpress: Tactical Wireless Automation**

### **WiFiXpress** is a streamlined, tactical-grade WiFi utility built around the principle of **QaR** (*Quick and Respond*). Why waste precious time typing out endless commands, juggling multiple terminals, or sweating over syntax errors when WiFiXpress can handle the grunt work for you?

### With WiFiXpress, you can:
  -> **Run Hashcat Effortlessly**: Automate capturing and output preparation to send directly to your cracking tool of choice.  
  -> **Set Custom Capture Times**: Whether you're staying passive or diving in aggressively, the timer feature gives you precision control over your capture sessions.  
  -> **Switch Between Active and Passive Modes**: Go loud or stay sneaky-beaky—WiFiXpress responds to your operational needs.  
  -> **Save and Review History**: Every move you make is logged, so you can easily retrace your steps or refine your process.  
  -> **Generate Organized Outputs**: Never again sift through chaos; WiFiXpress provides clean and accessible data when you need it most.  

This tool isn’t just a utility; it’s your exit strategy when your time is important.**WiFiXpress** makes sure you can grab what you need and get out, fast and unnoticed.
And let's not shit ourselves—whether you're an operator under pressure or just someone too lazy to type airmon-ng for the hundredth time,<br> **WiFiXpress** has your back. It’s not just a tool 
-it’s a way of life for those who value speed, automation, and the occasional touch of recklessness.

## *Installation*
**Tools you need:** ```aircrack-ng (airodump-ng, aireplay-ng)```, ```hashcat```, ```tcpdump```.
**Just download WiFiXpress and:**<br>
set chmod permission to execute file
```
  chmod +x WifiXpress.sh
```
## Usage: 
```
  sudo ./WifiXpress.sh
```
### Provide your parameters: 
```
  Enter network interface: <Your Network Interface>
  BSSID: <Router BSSID>
  Enter Channel: <channel>
  Set time to capturing (optional:120sec):
  Output: <name your output without *.txt*>
```

## Troubleshooting: 
### 🔴**tools not found**: 
```tools not found, Install it before using script```
Fix: Install the necessary tools:
Ubuntu/Debian:
```
sudo apt install aircrack-ng
```
Arch:
```
sudo pacman -S aircrack-ng
```
Fedora:
```
sudo dnf install aircrack-ng
```
### 🔴**Network Interface is not avaiable/error**:
```
  Error: The network interface <INTERFACE> does not exist!
  [The IF with Net.Inter. search]-> [if ! ip link show "$INTERFACE" &>/dev/null; then...]
```
Fix: Provide a **valid network interface** name.
-> Still broken? Manually identify the interface name and comment out lines 55-65 in the script.

### QaR Philosophy
*Quick and Response (QaR) – Scripts and automation that make shit happen without the annoying manual grind. I build tools that take care of the boring stuff so you can stop wasting time and just get things done. No more babysitting your computer —just provide inputs and lets roll.*
Daaamn son, you'll see what real automation is all about! (O^O)
**"Quick hands save lives!"**

##Disclaimer: 
**This tool is for ethical purposes only. Illegal activity? Not my problem, kek.**
