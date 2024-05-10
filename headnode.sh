#!/bin/bash

# Parámetros
nombreOvS="$1"
InterfacesAConectar="$2"

# Función para verificar el estado de la operación
function check_status {
    if [ $? -eq 0 ]; then
        echo "Operación completada: $1"
    else
        echo "Error durante la operación: $1"
        exit 1
    fi
}

# Crear o verificar existencia del OvS local en el HeadNode
ovs-vsctl br-exists "$nombreOvS" || ovs-vsctl add-br "$nombreOvS"
check_status "crear/agregar el bridge $nombreOvS"

# Activar el bridge
ip link set dev "$nombreOvS" up
check_status "activar el bridge $nombreOvS"

# Conectar las interfaces al OvS
for iface in $InterfacesAConectar; do
    echo "Procesando interfaz: $iface..."
    ip link show "$iface" > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        ovs-vsctl add-port "$nombreOvS" "$iface"
        check_status "añadir el puerto $iface a $nombreOvS"
    else
        echo "La interfaz $iface no existe, por favor verifica los nombres de las interfaces."
    fi
done

# Activar IPv4 Forwarding
sysctl -w net.ipv4.ip_forward=1
check_status "activar IPv4 forwarding"

# Cambiar la acción predeterminada del chain FORWARD a DROP
# Considera ajustar o deshabilitar esta línea si afecta la conectividad que necesitas
iptables -P FORWARD DROP
check_status "establecer política FORWARD a DROP"

# Mensaje de confirmación de inicialización
echo "HeadNode inicializado correctamente."
