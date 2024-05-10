#!/bin/bash

# Parámetros
nombreDeOvS="$1"
InterfacesAConectar="$2"

# Verificar y crear el bridge de OvS si no existe
ovs-vsctl br-exists "$nombreDeOvS" || ovs-vsctl add-br "$nombreDeOvS"

# Activar el bridge
ip link set dev "$nombreDeOvS" up

# Conectar las interfaces al bridge
for iface in $InterfacesAConectar; do
    ip link show "$iface" > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        ovs-vsctl add-port "$nombreDeOvS" "$iface"
        echo "Conectada $iface a $nombreDeOvS"
    else
        echo "La interfaz $iface no existe."
    fi
done

echo "Inicialización completada."
