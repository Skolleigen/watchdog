#!/bin/bash
VERSION="2.0"

# ────────────────────────────
# CLI Flags
# ────────────────────────────
if [[ "$1" == "--version" ]]; then
    echo "🐾 Watchdog v$VERSION – Lightweight Security Layer"
    exit 0
elif [[ "$1" == "--help" ]]; then
    echo -e "🐾 Watchdog v$VERSION – Lightweight Security Layer"
    echo -e "Usage:\n  watchdog              Run full scan"
    echo -e "  watchdog --version    Show version"
    echo -e "  watchdog --help       Show this help message"
    exit 0
fi

LOGFILE=~/security-log-$(date +%F_%H-%M).txt

# HEADER
echo "🔥 Watchdog v2.0 – System Incursion Scanner" | tee "$LOGFILE"
echo "Run at: $(date)" | tee -a "$LOGFILE"
echo "User: $(whoami) | Host: $(hostname)" | tee -a "$LOGFILE"
echo "---------------------------------------------" | tee -a "$LOGFILE"

# 🔒 FIREWALL STATUS
check_firewall() {
    echo -e "\n🔒 UFW Firewall Status" | tee -a "$LOGFILE"
    sudo ufw status verbose | tee -a "$LOGFILE"
}

# 🕵️ PORT & SERVICE SCAN
scan_ports() {
    echo -e "\n🕵️ Open Ports and Listening Services" | tee -a "$LOGFILE"
    sudo ss -tulnp | tee -a "$LOGFILE"
}

# 📡 ACTIVE INTERNET CONNECTIONS
active_connections() {
    echo -e "\n📡 Active Internet Connections" | tee -a "$LOGFILE"
    sudo lsof -i -P -n | grep ESTABLISHED | tee -a "$LOGFILE"
}

# 🦠 CLAMAV ANTIVIRUS SCAN
run_clamav_scan() {
    echo -e "\n🦠 ClamAV Scan (Home Directory)" | tee -a "$LOGFILE"
    if systemctl is-active --quiet clamav-freshclam; then
        echo "🛑 ClamAV updater is running, stopping it temporarily..." | tee -a "$LOGFILE"
        sudo systemctl stop clamav-freshclam
        sudo freshclam | tee -a "$LOGFILE"
        sudo systemctl start clamav-freshclam
    else
        echo "✅ ClamAV updater is not running, running manual update..." | tee -a "$LOGFILE"
        sudo freshclam | tee -a "$LOGFILE"
    fi

    sudo clamscan -r --bell -i ~/ | tee -a "$LOGFILE"
}

# 🐚 SUSPICIOUS PROCESSES
check_suspicious_procs() {
    echo -e "\n🐚 Suspicious Shell or Network Processes" | tee -a "$LOGFILE"
    ps aux | egrep 'nc|ncat|bash -i|python -c|/dev/tcp|/dev/udp|socat' | grep -v grep | tee -a "$LOGFILE"
}

# 🎭 CURRENTLY LOGGED-IN USERS
who_is_logged_in() {
    echo -e "\n🎭 Currently Logged-in Users" | tee -a "$LOGFILE"
    who | tee -a "$LOGFILE"
}

# 🛡️ VPN STATUS CHECK
vpn_status() {
    echo -e "\n🛡️ VPN Status & Public IP" | tee -a "$LOGFILE"
    echo "🔎 Current Public IP:" | tee -a "$LOGFILE"
    curl -s ifconfig.me | tee -a "$LOGFILE"
    echo "" | tee -a "$LOGFILE"
    echo "🌐 IP Intelligence:" | tee -a "$LOGFILE"
    curl -s ipinfo.io | tee -a "$LOGFILE"
}

# 🧅 TOR STATUS
tor_status() {
    echo -e "\n🧅 Tor Service Check" | tee -a "$LOGFILE"
    if systemctl is-active --quiet tor@default.service; then
        echo "✅ Tor is running." | tee -a "$LOGFILE"
    else
        echo "❌ Tor is inactive." | tee -a "$LOGFILE"
    fi
}

# 🌐 DNS LEAK CHECK (BASIC)
dns_leak_check() {
    echo -e "\n🌐 DNS Leak Check (resolv.conf)" | tee -a "$LOGFILE"
    cat /etc/resolv.conf | grep nameserver | tee -a "$LOGFILE"
}

# 🚨 OPTIONAL: DESKTOP NOTIFICATION
send_notification() {
    if command -v notify-send &> /dev/null; then
        notify-send "✅ Watchdog Scan Complete" "Log saved to: $LOGFILE"
    fi
}

# RUN ALL CHECKS
check_firewall
scan_ports
active_connections
run_clamav_scan
check_suspicious_procs
who_is_logged_in
vpn_status
tor_status
dns_leak_check
send_notification

echo -e "\n✅ Watchdog scan complete. Log saved at: $LOGFILE"

