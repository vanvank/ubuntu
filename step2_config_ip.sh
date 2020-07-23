#!/bin/bash
echo "请修改01-netcfg.yaml中的网卡名和ip配置"
cp 01-netcfg.yaml /etc/netplan/01-netcfg.yaml
netplan try
