# 更新sources.list
cp sources.list /etc/apt/sources.list


# 免密登录的user，同时也是后面lotus_data所有者
echo -n "请输入要设置免密登录的用户名："
read user
echo -n "服务器是否位于国内:(y/n): "
read cn

echo "设置免密登录"
echo "$user ALL = (root) NOPASSWD:ALL" | tee /etc/sudoers.d/$user
chmod 0440 /etc/sudoers.d/$user

# time adjust
if [[ $cn == 'y' ]]
then
  echo "time adjust"
  sed -i '/NTP=ntp.aliyun.com/d' /etc/systemd/timesyncd.conf
  sed -i '/\[Time\]/a\NTP=ntp.aliyun.com' /etc/systemd/timesyncd.conf
  systemctl restart systemd-timesyncd
fi

# 加入跳板机
apt update
apt install python python3 vim -y
echo "加入跳板机"
if [ ! -f /root/.ssh/id_rsa ]
then
ssh-keygen -t rsa -P "" -f /root/.ssh/id_rsa
fi
sleep 3
sed -i '/root@jumpserver/d' /root/.ssh/authorized_keys
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQChX8CES8CFN7QZvdONS517NcJxJZhUQSdLUfeR/dyp1qF5UApOyeDaVyVQID9wpLOKBu62VV21X1FKLt3DS3CTst8aLjXdae+9VshfS4yjWQCQlwodacgBtFqToWwc2if1MlnYEFl9e5dhNnxrFaUwrZSZXI1gA5DuCOxMRRvWHaWwXSfoPpnK4+18DHOmPDd4goVIexbshqWcpohIhmvTOmxlujo4nsEslwBoAVQksJqUnjsn13ALITtltlXO2dWmDtMf7qp/quH3QQEoXRpCzsUZbMBngfUM7DrqsiR7vlZr1xz8gVuVaE6RGoMO93r5Ai05ZeB0qlbNCFUGHJEx root@jumpserver' >>  /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys
