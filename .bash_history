exit
loadkeys latam
lsblk
df -h
sudo growpart /dev/vda 1
df -h
resize2fs /dev/vda1
df -h
hostname ctl
hostnamectl set-hostname HeadNode
BASH
bash}
bash
ls
df -h
apt install iperf
dhclient ens3
ip link
ip add
dhclient
ip addr
ip link
ip link set up
ip link dev ens3 set up
ip link set dev ens3 up
ip link set dev ens3 down
ip link set dev ens3 up
dhclient ens3
ip addr
dhclient ens5
dhclient ens4
ip addr
rebooty
reboot
tcpdump -i ens3 -enn
exit
dhclient -v ens3
ip link
dhclient -v ens3
ip addr add 10.20.12.70/24 dev ens3
ip link
ping 10.20.12.1
ping 10.20.12.2
ping 10.20.12.3
ping 10.20.12.4
ping 10.20.12.1
ip addr del 10.20.12.70/24 dev ens3
dhclient -v ens3
exit
ip addr
systemctl status sshd
exit
passwd
getent passwd
loadkeys latam
getent passwd latam
getent passwd
getent passwd | grep ubuntu
adduser ubuntu
usermod -aG sudo ubuntu
su ubuntu
nano /etc/ssh/sshd_config
nano /etc/netplan/
nano /etc/netplan/config.yaml
ip addr
nano /etc/netplan/config.yaml
netplan apply
ip addr
nano /etc/ssh/sshd_config
ping 8.8.8.8
ip route
ip addr
ip route add 0.0.0.0/0 via 10.0.0.1
ping 8.8.8.8
reboot
ip addr
ping 8.8.8.8
nano /etc/netplan/config.yaml
netplan apply
nano /etc/netplan/config.yaml
netplan apply
nano /etc/netplan/config.yaml
netplan apply
nano /etc/netplan/config.yaml
netplan apply
nano /etc/netplan/config.yaml
netplan apply
nano /etc/netplan/config.yaml
netplan apply
ip addr
ip route
exit
nano /etc/netplan/config.yaml 
netplan apply
ip addr
nano /etc/netplan/config.yaml
exit
touch /etc/cloud/cloud-init.disabled
getent passwd
deluser jp
adduser gira
usermod -aG sudo gira
su gira
exit
ssh gira@10.0.0.1
exit
nano /etc/netplan/config.yaml
exit
nano /etc/sysctl.conf
sysctl -p
ip neigh 
ssh gira@10.0.0.20
ssh gira@10.0.0.10
ssh gira@10.0.0.30
ip addr
tcpdump -i ens4 host 10.0.0.30 
cat /proc/sys/net/ipv4/ip_forward
tcpdump -i ens4 host 10.0.0.30 
ssh gira@10.0.10.1
sudo apt install iptables-persistent
ping 8.8.8.8
nano /etc/resolv.conf 
ping 8.8.8.8
sudo apt install iptables-persistent
ip addr
iptables -t nat -A POSTROUTING -o ens3 -j MASQUERADE
iptables-save > /etc/iptables/rules.v4
iptables -t nat -L -nv
ssh gira@10.0.10.1
iptables -t nat -L
nano /etc/iptables/rules.v
nano /etc/iptables/rules.v4
exit
clear
cd /etc
nano resolv.conf 
cd
apt install openvswitch-switch
nano /etc/iptables/rules.vcd
clear
ip lin
ovs-vsctl add-br ovs-br0
ovs-vsctl show
ovs-vsctl del-br ovs-br0
ovs-vsctl show
ovs-vsctl add-port ovs-br0 eth0
ovs-vsctl del-br ovs-br0
ovs-vsctl add-br ovs-br0
ovs-vsctl show
ovs-vsctl add-port ovs-br0 eth0
ip link set veth-0
ip link add veth0 type veth peer name veth1
ovs-vsctl add-port ovs-br0 eth0
ovs-vsctl add-port ovs-br0 veth1
ovs-vsctl add-port ovs-br0 ens1
ovs-vsctl add-port ovs-br0 ens3
clear
ip link set veth1 master br0
ip link set veth0 master br1
ip link
brctl show br1
apt install bridge-utils 
cd /etc
ls
nano resolv.conf 
apt install bridge-utils 
cd 
brctl show br1
brctl show br
brctl show --help
brctl sho
brctl show
$ brctl delif br0 eth1
$ brctl delbr br0 eth1
$ brctl delbr br0 
$ brctl --help
$ brctl show --help
ip link del br0 type bridge
ip link del br1 type bridge
brctl show
ip link
ip link del veth0
ip link 
clear
ip netns lis
ip netns add ns1
ip netns add ns2
ip netns list
ip link add br1 type bridge
ip addr
clear
ip netns list
ip link show type bridge
ip link add br1-eth0 type veth peer name srv-eth0
ip link add br1-eth1 type veth peer name ns1-eth0
ip link add br1-eth2 type veth peer name ns2-eth0
ip link show type veth
ip link set br1-eth1 master br1
ip link set br1-eth2 master br1
ip link set srv-eth0 netns ns-dhcp-server
ip link set ns1-eth0 netns ns1
ip link set ns2-eth0 netns ns2
clear
ip netns exec ns-dhcp-server ip link
ip netns exec ns1 ip link
ip netns exec ns2 ip link
ip link show master br1
ip link set dev br1-eth0 up
ip link set dev br1-eth1 up
ip link set dev br1-eth2 up
clear
ip netns exec ns-dhcp-server ip link set dev lo up
ip netns exec ns-dhcp-server ip link set dev srv-eth0 up
ip link show ns-dhcp-server
ip link
clear
ip netns exec ns-dhcp-server ip link
clear
ip netns exec ns-dhcp-server ip link set dev srv-eth0 up
ip netns exec ns1 ip link set dev lo up
ip netns exec ns1 ip link set dev ns1-eth0 up
ip netns exec ns2 ip link set dev lo up
ip netns exec ns-dhcp-server ip link
ip netns exec ns1 ip link
ip netns exec ns2 ip link
ip link show type bridge
ip link show master br1
ip netns exec ns-dhcp-server dnsmasq --interface=srv-eth0 --dhcp-range=10.0.0.2,10.0.0.6,255.255.255.248
ps -ef | grep dnsmasq
ip netns identify 125771
ip netns exec ns-dhcp-server ip address add 10.0.0.6/29 dev srv-eth0
ip netns exec ns1 ip -4 address
ip netns exec ns2 ip -4 address
ip netns exec ns1 dhclient ns1-eth0 -d
clear
ip netns exec ns2 ip -4 address
ip netns exec ns1 ip -4 address
ip netns exec ns2 dhclient ns2-eth0 -d
ip netns exec ns2 ip -4 address
ip netns exec ns1 ip -4 address
ip netns exec ns2 ip -4 address
clear
ip netns exec ns1 ping 10.0.0.5
ip netns exec ns2 ping 10.0.0.2
ip netns exec ns2 ping 10.0.0.3
ip netns exec ns2 ping 10.0.0.2
ip netns exec ns1 ping 10.0.0.5
clear
ip netns del ns-dhcp-server
ip netns del ns1
ip netns del ns2
ip link del br1-eth0
ip link del br1-eth1
ip link del br1-eth2
ip link del br1
ip link
ip addr
clear
ip netns add ns1
ip nets list
ip nets show list list
ip nets show list
ip nets lists
ip netns lists
ip netns list
ip netns add ns2
ip netns list
ovs-vsctl add-br ovs1
ovs-vsctl list-br
ip link add ovs1-eth1 type veth peer name ns1-eth0
ip link add ovs1-eth2 type veth peer name ns2-eth0
ip link show type veth
clear
ip link set ns1-eth0 netns ns1
ip link set ns2-eth0 netns ns2
ip netns exec ns1 ip link
ip netns exec ns2 ip link
ovs-vsctl add-port ovs1 ovs1-eth1
ovs-vsctl add-port ovs1 ovs1-eth2
ovs-vsctl list-ports ovs1
ip link set dev ovs1-eth1 up
ip link set dev ovs1-eth2 up
ip netns exec ns1 ip link set dev lo up
ip netns exec ns1 ip link set dev ns1-eth0 up
ip netns exec ns2 ip link set dev lo up
ip netns exec ns2 ip link set dev ns2-eth0 up
ip netns exec ns1 ip link
clear
ip netns exec ns1 ip link
ip netns exec ns2 ip link
ovs-ofctl show ovs1
clear
ip address add 10.0.0.1/29 dev ovs1
ip netns exec ns1 ip address add 10.0.0.2/29 dev ns1-eth0
ip netns exec ns1 ip route add default via 10.0.0.1
ip netns exec ns2 ip address add 10.0.0.3/29 dev ns2-eth0
ip netns exec ns2 ip route add default via 10.0.0.1
ip netns exec ns1 ip -4 address
ip netns exec ns1 ip route
ip netns exec ns2 ip -4 address
ip netns exec ns2 route
ip netns exec ns1 route
ip netns exec ns1 ip -4 address
ip netns exec ns1 route
ip netns exec ns2 ip -4 address
ip netns exec ns2 route
ip -4 address show ovs1
clear
iptables -t nat -L
clear
iptables -t nat -L
ps
ps -a
sysctl net.ipv4.ip_forward
ls
link
ip link
ip netns exec ns1 ping 10.0.0.2
ip netns exec ns1 ping 10.0.0.3
ip netns exec ns2 ping 10.0.0.2
ip netns exec ns2 ping 8.8.8.8
ip netns exec ns1 ping 8.8.8.8
clear
ip netns del ns1
ip netns del ns2
ovs-vsctl del-br ovs1
ip link del ovs-eth1
ip link
ip addr
clear
ovs-vsctl del-br ovs1
iptables -s 10.0.0.0/29 -t nat -D POSTROUTING -j MASQUERADE
clear
ip netns add ns-dhcp-server
ip netns list
ovs-vsctl add-br ovs1
ovs-vsctl list-br
wget -c https://download.cirros-cloud.net/0.5.1/cirros-0.5.1-x86_64-disk.img
ls -l | grep cirros
wget -c https://download.cirros-cloud.net/0.5.1/cirros-0.5.1-x86_64-disk.img
cd etc/
cd /etc
nano resolv.conf 
cd
wget -c https://download.cirros-cloud.net/0.5.1/cirros-0.5.1-x86_64-disk.img
ls -l | grep cirros
ip tuntap add mode tap name ovs1-tap1
ip tuntap add mode tap name ovs1-tap2
ip tuntap list
clear
qemu-system-x86_64 -enable-kvm -vnc 0.0.0.0:1 -netdev tap,id=ovs1-tap1,ifname=ovs1-tap1,script=no,downscript=no -device e1000,netdev=ovs1-tap1,mac=20:20:04:03:mi:ke -daemonize -snapshot cirros-0.5.1-x86_64-disk.img
qemu-system-x86_64 -enable-kvm -vnc 0.0.0.0:1 -netdev tap,id=ovs1-tap1,ifname=ovs1-tap1,script=no,downscript=no -device e1000,netdev=ovs1-tap1,mac=20:20:04:03:mi:ke -daemonize -snapshot cirros-0.5.1-x86_64-disk.img 
qemu-system-x86_64 -enable-kvm -vnc 0.0.0.0:2 -netdev tap,id=ovs1-tap2,ifname=ovs1-tap2,script=no,downscript=no -device e1000,netdev=ovs1-tap2,mac=20:20:04:03:be:be -daemonize -snapshot cirros-0.5.1-x86_64-disk.img
grep -E 'svm|vmx' /proc/cpuinfo
CLEAR
clear
grep -E 'svm|vmx' /proc/cpuinfo
qemu-system-x86_64 -enable-kvm -vnc 0.0.0.0:2 -netdev tap,id=ovs1-tap2,ifname=ovs1-tap2,script=no,downscript=no -device rtl8139,netdev=ovs1-tap2,mac=20:20:04:03:be:be -daemonize -snapshot cirros-0.5.1-x86_64-disk.img -cpu host
ovs-vsctl add-port ovs1 ovs1-tap1
ovs-vsctl add-port ovs1 ovs1-tap2
clear
ps -ef | grep qemu
ss -tulpn | grep -i listen
sudo lxc list
xd
clear
sudo lxc list
ls
qemu-system-x86_64 -enable-kvm -vnc 0.0.0.0:1 -netdev tap,id=ovs1-tap1,ifname=ovs1-tap1,script=no,downscript=no -device e1000,netdev=ovs1-tap1,mac=20:20:04:03:be:be -daemonize -snapshot cirros-0.5.1-x86_64-disk.img
ps -aux | grep qemu
ls
cp cirros-0.5.1-x86_64-disk.img cirros-0.5.1-x86_64-disk2.img
kill -9 126424
kill -9 127944
qemu-system-x86_64 -enable-kvm -vnc 0.0.0.0:1 -netdev tap,id=ovs1-tap1,ifname=ovs1-tap1,script=no,downscript=no -device e1000,netdev=ovs1-tap1,mac=20:20:04:03:be:be -daemonize -snapshot cirros-0.5.1-x86_64-disk.img
qemu-system-x86_64 -enable-kvm -vnc 0.0.0.0:2 -netdev tap,id=ovs1-tap2,ifname=ovs1-tap2,script=no,downscript=no -device e1000,netdev=ovs1-tap2,mac=20:20:04:03:be:be -daemonize -snapshot cirros-0.5.1-x86_64-disk2.img
ps -aux | grep qemu
ps -ef | grep qemu
ss -tulpn | grep -i listen
clear
ovs-vsctl add-port ovs1 ovs1-tap1
ovs-vsctl list-ports ovs1
ovs-vsctl set interface ovs1-tap0 type=internal
ovs-vsctl add-port ovs1-tap0 --set interface ovs1-tap0 type=internal
ovs-vsctl add-port ovs1-tap0 -- set interface ovs1-tap0 type=internal
ovs-vsctl add-port ovs1 ovs1-tap0 -- set interface ovs1-tap0 type=internal
ip link set ovs1-tap0 netns ns-dhcp-server
ip netns exec ns-dhcp-server ip link set dev ovs1-tap0 up
ip link set dev ovs1-tap1 up
ip link set dev ovs1-tap2 up
ovs-ofctl show ovs1
ip netns exec ns-dhcp-server ip link
ip link set dev ovs1 up
clear
ip netns exec ns-dhcp-server ip address add 10.0.0.14/29 dev ovs1-tap0
ip address add 10.0.0.9/29 dev ovs1
ip netns exec ns-dhcp-server dnsmasq --interface=ovs1-tap0 --dhcp-range=10.0.0.10,10.0.0.13,255.255.255.248 --dhcp-option=3,10.0.0.9
ps -ef | grep qemu
ss -tulpn | grep -i listen
ip addr
ls
clear
ssh ubuntu@10.0.0.9 -p 5901
ssh ubuntu@10.0.0.9 -p 5902
ssh ubuntu@10.0.0.11 -p 5902
ssh ubuntu@10.0.0.11 -p 5901
ssh ubuntu@10.0.0.10 -p 5901
ssh ubuntu@10.0.0.12 -p 5901
ssh ubuntu@10.0.0.13 -p 5901
clear
ps
ip netns exec ns-dhcp-server ip -4 address
ip -4 address show ovs1
iptables -s 10.0.0.8/29 -t nat -A POSTROUTING -j MASQUERADE
sysctl net.ipv4.ip_forward
ip netns exec ns-dhcp-server ip -4 address
iptables -t nat -L
clear
history
iptables -t nat -L
exit
sudo iptables -L
sudo apt install iptables-persistent
cd /etc
ls
nano resolv.conf 
cd
sudo apt install iptables-persistent
clear
cd /etc/iptables/
ls
sudo iptables-save > /etc/iptables/rules.v4
sudo ip6tables-save > /etc/iptables/rules.v6
ls
nano rules.v4
cd
history
clear
sudo dnf install iptables-services
dnf install iptables-services
sudo systemctl status iptables
clear
ip addr
ovs-vsctl list-ports ovs1
clear
ovs-ofctl show ovs1
ssh ubuntu@10.0.0.30 -p 22
nano /etc/iptables/rules.v4
exit
cd la
ls
cd
ls
exit
ls
exit
ls
clear
ovs-vsctl show
nano create_vm.sh
chmod +x create_vm.sh 
sudo ./create_vm.sh myvm br-int 100 1
nano create_vm.sh
sudo ovs-vsctl del-port br-int tap_myvm
sudo pkill -f 'qemu-system-x86_64.*myvm'
sudo ip link delete tap_myvm
ovs-vsctl show
ovs-vsctl del-br mi_red
ovs-vsctl show
sudo ./create_vm.sh myvm br-int 100 1
nano create_vm.sh
sudo ./create_vm.sh myvm br-int 100 1
sudo pkill -f 'qemu-system-x86_64.*myvm'
sudo ip link delete tap_myvm
sudo ovs-vsctl del-port br-int tap_myvm
sudo ./create_vm.sh myvm br-int 100 1
ovs-vsctl show
nano create_vm.sh
sudo ovs-vsctl --if-exists del-port $ovs_name $tap_name
sudo ip link delete $tap_name type tap --if-exists
sudo pkill -f 'qemu-system-x86_64.*'$vm_name
sudo ./create_vm.sh myvm br-int 100 1
cd var
cd /var/
ls
nano create_vm.sh
cd
nano create_vm.sh
sudo ./create_vm.sh myvm br-int 100 1
ps aux | grep qemu-system-x86_64
ip link show
ip link del br-int
nano create_vm.sh
sudo ./create_vm.sh myvm1 br-int 100 1
sudo ./create_vm.sh myvm1 br-int1 101 1
ovs-vsctl show
ovs-vsctl del-br br-int
ovs-vsctl show
ip addr
sudo ip link delete tap_myvm
sudo ip link delete br-int-myvm-tap
sudo ip link delete tap_myvm1
ip addr
sudo ./create_vm.sh myvm1 br-int1 101 1
ovs-vsctl show
ip addr
ip link delete tap_myvm1 
clear
nano conectar_vlans.sh
nano existe_vlan.sh
chmod +x existe_vlan.sh 
./existe_vlan.sh 
ls
exit
clear
nano headnode.sh
nano network_headnode.sh
ls
nano create_vm.sh 
lsclear
clear
ls
nano conectar_vlans.sh 
nano internet_vlan.sh
ls
nano worker.sh
clear
ls
pip install paramiko
cat /etc/resolv.conf
cd /etc/
nano resolv.conf 
nano resolv.conf cd
ls
cd
clear
pip install paramiko
python3
clear
LS
ls
nano orquestador.py
ovs-vsctl show
python orquestador.py
python3 orquestador.py
ip addr
ovs-vsctl 
ovs-vsctl show
python3 orquestador.py
clear
nano orquestador.py 
python3 orquestador.py
nano orquestador.py 
python3 orquestador.py
nano orquestador.py 
python3 orquestador.py
ssh ubuntu@10.0.0.50
python3 orquestador.py
sudo ovs-vsctl show
sudo iptables -L -v
sudo iptables -t nat -L -v
ip route show
sudo ovs-vsctl list port
ls
python3 orquestador.py 
nano orquestador.py 
LS
ls
de cirros-0.5.1-x86_64-disk2.img 
rm cirros-0.5.1-x86_64-disk2.img 
ls
rm snap/
cd snap/
ls
cd la
cd lxd/
ls
cd
nano internet_vlan.sh 
scp cirros-0.5.1-x86_64-disk.img ubuntu@10.0.0.30:/home/ubuntu
scp cirros-0.5.1-x86_64-disk.img ubuntu@10.0.0.40:/home/ubuntu
scp cirros-0.5.1-x86_64-disk.img ubuntu@10.0.0.50:/home/ubuntu
clear
nano orquestador.py 
