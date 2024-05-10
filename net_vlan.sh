#!/bin/bash

# Parámetros
vlan_id="$1"

# Interfaz de red de Management/Internet
internet_interface="eth0"

# Crear una regla iptables para permitir tráfico de salida desde la VLAN hacia Internet
iptables -A FORWARD -i br-int -o $internet_interface -m vlan --vlan-id $vlan_id -j ACCEPT

# Crear una regla iptables para permitir tráfico de entrada desde Internet hacia la VLAN
iptables -A FORWARD -i $internet_interface -o br-int -m vlan --vlan-id $vlan_id -j ACCEPT

# Habilitar el enrutamiento de paquetes
echo 1 > /proc/sys/net/ipv4/ip_forward

echo "Reglas de iptables configuradas para la VLAN con ID $vlan_id."
