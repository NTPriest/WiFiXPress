## **WiFiXpress: Tactical Wireless Automation**

Is automation automatic-utility built around the principle of **QaR** (*Quick and Respond*).<br> 
Why waste precious time typing out endless commands, juggling multiple terminals, or sweating over syntax errors, when WiFiXpress can handle the grunt work for you.

### With WiFiXpress, you can:
  -> **Run Hashcat Effortlessly**: Automate capturing and output preparation to send directly to your cracking tool of choice.  
  -> **Set Custom Capture Times**: Whether you're staying passive or diving in aggressively, the timer feature gives you precision control over your capture sessions.  
  -> **Active/Passive Modes**: Go loud or stay sneakybeaky~ —WiFiXpress responds to your operational needs.  
  -> **Save and Review History**: Every move you make is logged, so you can easily retrace your steps or refine your process.  
  -> **Generate Organized Outputs**: Never again sift through chaos; WiFiXpress provides clean and accessible data when you need it most.  

Let's not shit ourselves —whether you're an operator under pressure or just someone too lazy to type airmon-ng for the hundredth time,<br> **WiFiXpress** has your back.<br> It’s not just a tool 
-it’s a way of life for those who value speed, automation, and the occasional touch of recklessness.

## *Installation*
**Tools you need:** ```aircrack-ng (airodump-ng, aireplay-ng)```, ```hashcat```, ```tcpdump```.<br>

**Just download WiFiXpress and:**<br>
set chmod permission to execute file: 
```
  chmod +x WifiXpress.sh
```
### Usage: 
```
  sudo ./WifiXpress.sh
```
### Enter parameters: 
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
```
Fix: Provide a **valid network interface** name.<br>
-> Still broken? Manually identify the interface name and comment out lines 55-65 in the script with:<br> ```:<< END <Code lines 55-65> END```:

### QaR Philosophy
*Quick and Response (QaR) – Scripts and automation that make shit happen without the annoying manual grind. I build tools that take care of the boring stuff so you can stop wasting time and just get things done. No more babysitting your computer —just provide inputs and lets roll.*<br>
Daaamn son, you'll see what real automation is all about! (O^O)<br>
**"Quick hands save lives!"**

## Disclaimer: 
**This tool is provided for educational and ethical purposes only. The developer is not responsible for any misuse, illegal activity, or damages caused by the use of this software. Use it at your own risk. Kek**
