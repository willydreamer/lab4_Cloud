#!/bin/bash

# Parámetros
VLAN_ID_1="$1"  # ID de la VLAN 1
VLAN_ID_2="$2"  # ID de la VLAN 2

# Habilitar el enrutamiento IPv4
echo "Habilitando el enrutamiento IPv4..."
echo 1 > /proc/sys/net/ipv4/ip_forward

# Función para obtener CIDR de la interfaz de VLAN
get_vlan_cidr() {
    local vlan_id="$1"
    local interface_name=$(sudo ovs-vsctl list port | grep "$vlan_id" | awk '{print $3}' | head -n 1)

    if [ -z "$interface_name" ]; then
        echo "No se encontró ninguna interfaz con VLAN ID $vlan_id."
        return 1  # Devuelve código de error para indicar fallo
    fi

    local interface_info=$(ip addr show dev "$interface_name")
    local ip_address=$(echo "$interface_info" | awk '/inet / {split($2, ip_parts, "/"); print ip_parts[1]}')
    local subnet_mask=$(echo "$interface_info" | awk '/inet / {print $2}' | awk -F/ '{print $2}')

    if [ -z "$ip_address" ] || [ -z "$subnet_mask" ]; then
        echo "No se pudo obtener la dirección IP o la máscara de subred para la interfaz $interface_name."
        return 1  # Devuelve código de error para indicar fallo
    fi

    echo $(ipcalc -n $ip_address/$subnet_mask | awk '/Network/ {print $2}')  # Retorna CIDR de la red
}

# Obtener CIDR de ambas VLANs
echo "Obteniendo información de red para VLAN $VLAN_ID_1..."
if vlan_cidr_1=$(get_vlan_cidr "$VLAN_ID_1"); then
    echo "Dirección de red para VLAN $VLAN_ID_1 es $vlan_cidr_1."
else
    echo "Fallo al obtener la dirección de red para VLAN $VLAN_ID_1."
    exit 1
fi

echo "Obteniendo información de red para VLAN $VLAN_ID_2..."
if vlan_cidr_2=$(get_vlan_cidr "$VLAN_ID_2"); then
    echo "Dirección de red para VLAN $VLAN_ID_2 es $vlan_cidr_2."
else
    echo "Fallo al obtener la dirección de red para VLAN $VLAN_ID_2."
    exit 1
fi

# Permitir el tráfico entre las dos subredes VLAN
echo "Configurando iptables para permitir el tráfico entre las VLANs..."
sudo iptables -A FORWARD -i br-int -o br-int -s "$vlan_cidr_1" -d "$vlan_cidr_2" -j ACCEPT
sudo iptables -A FORWARD -i br-int -o br-int -s "$vlan_cidr_2" -d "$vlan_cidr_1" -j ACCEPT

# Asegurar que el tráfico de retorno también esté permitido
sudo iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

echo "Comunicación entre VLANs $vlan_cidr_1 y $vlan_cidr_2 ha sido configurada correctamente."
