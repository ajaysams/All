#!/bin/bash

# Download and extract menu.zip
apt update -y
apt install -y unzip

    wget https://raw.githubusercontent.com/ajaysams/All/main/menu/menu_sh.zip
    unzip menu_sh.zip
    chmod +x menu_sh/menu/*
    mv menu_sh/menu/* /usr/local/sbin
    rm -rf menu_sh
    rm -rf menu_sh.zip
    
    wget https://raw.githubusercontent.com/ajaysams/All/main/menu/menu2_py.zip
    unzip menu2_py.zip
    chmod +x menu2_py/menu/*
    mv menu2_py/menu/* /usr/bin
    rm -rf menu2_py
    rm -rf menu2_py.zip
    
    # Create symlink to make menu accessible from anywhere
    ln -sf /usr/bin/menu /usr/local/sbin/menu 2>/dev/null || true   
