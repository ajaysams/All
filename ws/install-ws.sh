#!/bin/bash

rm -f $0

file_path="/etc/handeling"
repo="https://raw.githubusercontent.com/ajaysams/All/main"

apt update
apt install python3 -y
apt install python3-pip -y
apt install python3-requests -y

# Check if file exists
if [ ! -f "$file_path" ]; then
    # If file doesn't exist, create file and fill with two lines
    echo -e "Switching Protocols\nYellow" | sudo tee "$file_path" > /dev/null
    echo "File '$file_path' successfully created."
else
    # If file exists, check if it's empty
    if [ ! -s "$file_path" ]; then
        # If file exists but is empty, fill with two lines
        echo -e "Switching Protocols\nYellow" | sudo tee "$file_path" > /dev/null
        echo "File '$file_path' is empty and has been filled."
    else
        # If file exists and contains data, do nothing
        echo "File '$file_path' already exists and contains data."
    fi
fi

cd /usr/local/bin
wget -q -O vpn.zip "${repo}/ws/vpn.zip"
unzip vpn.zip
cp ws ws-ovpn
chmod +x ws ws-ovpn
rm vpn.zip
cd

# Installing Service
cat > /etc/systemd/system/ws.service << END
[Unit]
Description=Proxy Mod
Documentation=https://google.com
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/ws
Restart=on-failure

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl enable ws.service
systemctl start ws.service
systemctl restart ws.service

# Installing Service
cat > /etc/systemd/system/ws-ovpn.service << END
[Unit]
Description=Proxy Mod
Documentation=https://google.com
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/ws-ovpn 2086
Restart=on-failure

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl enable ws-ovpn
systemctl start ws-ovpn
systemctl restart ws-ovpn
