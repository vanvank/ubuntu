#!/bin/bash
echo "请修改01-netcfg.yaml配置"
cp 01-netcfg.yaml /etc/netplan/01-netcfg.yaml
netplan try
