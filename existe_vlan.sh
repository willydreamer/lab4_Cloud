#!/bin/bash
echo "Listado de todas las VLANs en Open vSwitch:"
echo ""

# Lista todos los bridges primero
bridges=$(sudo ovs-vsctl list-br)
for bridge in $bridges; do
    echo "Bridge: $bridge"
    # Para cada bridge, lista todos sus puertos
    ports=$(sudo ovs-vsctl list-ports $bridge)
    for port in $ports; do
        # Obtener el tag de VLAN para cada puerto
        vlan_tag=$(sudo ovs-vsctl get port $port tag)
        echo "  Puerto: $port, VLAN Tag: $vlan_tag"
    done
    echo ""
done
