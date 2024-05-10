#!/bin/bash
# Parámetros
nombre_red="$1"
vlan_id="$2"
direccion_red_cidr="$3"  # Formato esperado: 192.168.100.0/24
rango_dhcp="$4"          # Formato esperado: 192.168.100.10,192.168.100.100

# Variables derivadas para la configuración
IFS='/' read -r ip_base mascara <<< "$direccion_red_cidr"
IFS='.' read -r a b c d <<< "$ip_base"
gateway="${a}.${b}.${c}.1"
dhcp_server_ip="${a}.${b}.${c}.2"

echo "Configurando la red interna y DHCP para $nombre_red con VLAN ID $vlan_id..."

# Crear la interfaz VLAN en el OvS
echo "Creando bridge y configurando VLAN..."
ovs-vsctl add-br "$nombre_red"
ovs-vsctl add-port "$nombre_red" vlan${vlan_id} -- set interface vlan${vlan_id} type=internal
ovs-vsctl set port vlan${vlan_id} tag=$vlan_id
echo "Bridge $nombre_red y VLAN $vlan_id creados y configurados."

# Configurar la dirección IP del gateway en la interfaz VLAN
echo "Configurando la dirección IP del gateway $gateway en la VLAN $vlan_id..."
ip link set dev vlan${vlan_id} up
ip addr add $gateway/24 dev vlan${vlan_id}
echo "Dirección IP del gateway configurada."

# Crear un namespace de red para DHCP
echo "Creando namespace para el servicio DHCP..."
ip netns add ${nombre_red}_dhcp
echo "Namespace ${nombre_red}_dhcp creado."

# Mover la interfaz del servidor DHCP al namespace creado y configurarla
echo "Configurando el servidor DHCP en el namespace..."
ip link set vlan${vlan_id} netns ${nombre_red}_dhcp
ip netns exec ${nombre_red}_dhcp ip addr add $dhcp_server_ip/24 dev vlan${vlan_id}
ip netns exec ${nombre_red}_dhcp ip link set dev vlan${vlan_id} up
echo "Dirección IP $dhcp_server_ip configurada para el servidor DHCP en el namespace."

# Configurar el servidor DHCP en el namespace
echo "Iniciando dnsmasq con configuración de DHCP..."
ip netns exec ${nombre_red}_dhcp dnsmasq \
  --interface=vlan${vlan_id} \
  --bind-interfaces \
  --dhcp-range=$rango_dhcp \
  --dhcp-option=option:router,$gateway \
  --dhcp-option=option:dns-server,8.8.8.8,8.8.4.4
echo "Dnsmasq configurado y ejecutándose."

echo "Configuración de red interna y DHCP completada para VLAN $vlan_id en $nombre_red."
