#!/bin/bash

# Parámetros
VLAN_ID="$1"  # ID de la VLAN para la cual se proporcionará acceso a Internet
INTERNET_INTERFACE="ens3"  

# Habilitar el enrutamiento IPv4
echo "Activando el enrutamiento IPv4..."
echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward > /dev/null

# Obtener el nombre de la interfaz asociada con la VLAN
INTERFACE_NAME=$(sudo ovs-vsctl list port | grep "vlan$VLAN_ID" | awk '{print $3}' | tail -n 1)
if [ -z "$INTERFACE_NAME" ]; then
    echo "Error: No se encontró una interfaz para VLAN ID $VLAN_ID."
    exit 1
fi

# Obtener la información de la dirección IP y la máscara de subred de la interfaz
INTERFACE_INFO=$(ip addr show dev $INTERFACE_NAME)
if [ -z "$INTERFACE_INFO" ]; then
    echo "Error: No se pudo obtener información de la interfaz $INTERFACE_NAME."
    exit 1
fi

# Extraer la dirección IP y la máscara de subred
IP_ADDRESS=$(echo "$INTERFACE_INFO" | awk '/inet / {split($2, ip_parts, "/"); print ip_parts[1]}')
SUBNET_MASK=$(echo "$INTERFACE_INFO" | awk '/inet / {print $2}' | awk -F/ '{print $2}')
VLAN_CIDR=$(ipcalc -n $IP_ADDRESS/$SUBNET_MASK | awk '/Network/ {print $2}')

echo "Configurando acceso a Internet para la VLAN con CIDR $VLAN_CIDR..."

# Reglas de iptables para habilitar el enrutamiento
sudo iptables -I FORWARD -s $VLAN_CIDR -j ACCEPT
sudo iptables -I FORWARD -d $VLAN_CIDR -j ACCEPT
sudo iptables -t nat -A POSTROUTING -s $VLAN_CIDR -o $INTERNET_INTERFACE -j MASQUERADE

# Asegurarse de que el tráfico de retorno esté permitido
sudo iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

echo "Acceso a Internet configurado correctamente para VLAN $VLAN_ID con dirección de red $VLAN_CIDR."
