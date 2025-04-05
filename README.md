# 🐶 Watchdog

**Lightweight Bash-based security scanner for Linux users who want insight, not overhead.**  
Monitors system integrity, VPN/Tor visibility, open ports, suspicious processes, and malware exposure — all in a single command.

---
![Uploading Watchdog.png…]()

## 🔍 What It Does

- 🔒 **Firewall status** (UFW)
- 🕵️ **Open ports** + listening services
- 📡 **Active internet connections**
- 🦠 **Antivirus scan** (ClamAV) with auto-update
- 🐚 **Suspicious shell/network processes**
- 🎭 **Logged-in users audit**
- 🛡 **VPN status** + public IP + IP intelligence
- 🧅 **Tor daemon check**
- 🌐 **DNS leak check**
- 🚨 **Desktop notification** on completion (if supported)

Logs are saved automatically with timestamped filenames like:

~/security-log-2025-04-05_21-34.txt


---

## ⚙️ Installation
🔌 Quick install (curl)

    curl -s https://raw.githubusercontent.com/Skolleigen/watchdog/main/install.sh | bash

This sets up the watchdog command globally on your system.
Run it anywhere using:

watchdog

Or for help/version:

    watchdog --help

🛠 Manual install

Clone the repo:


    git clone https://github.com/Skolleigen/watchdog.git
    cd watchdog
    chmod +x watchdog.sh

Then run it:

    ./watchdog.sh

🗂 Logs will be saved in your home directory unless redirected.
🧪 Requirements

    ufw

    clamav + clamav-freshclam

    curl

    lsof, ps, who

    notify-send (optional for notifications)

Install with:

sudo apt install ufw clamav curl lsof procps whois libnotify-bin

🚀 Coming Soon

    install.sh (system-wide setup)

    Flags like --quick, --tor, --scan-only

    Modular structure in modules/

    GUI or TUI interface (stretch goal)

Install all dependencies (Debian/Ubuntu):

    sudo apt install ufw clamav curl lsof procps whois libnotify-bin


📜 License

MIT License
🧠 Author

Made with 🔥 by @Skolleigen
🙏 Acknowledgements

    Inspired by personal infosec needs

    Powered by the Bash gods and caffeine


