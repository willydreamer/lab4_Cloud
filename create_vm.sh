#!/bin/bash

# Parámetros
vm_name="$1"
ovs_name="$2"
vlan_id="$3"
vnc_port="$4"

# Ruta a la imagen de CirrOS (asumiendo que se utiliza la primera imagen)
cirros_image="cirros-0.5.1-x86_64-disk.img"

# Nombre de la interfaz TAP
tap_name="tap_$vm_name"

# Eliminar la interfaz TAP si ya existe
if ip link show | grep -q $tap_name; then
    ip link set $tap_name down
    ip tuntap del mode tap dev $tap_name
fi

# Crear TAP interface para la VM
ip tuntap add $tap_name mode tap user `whoami`
ip link set $tap_name up

echo "Interfaz TAP $tap_name creada y levantada."

# Eliminar el puerto del OvS si ya existe
if ovs-vsctl list-ports $ovs_name | grep -q $tap_name; then
    ovs-vsctl del-port $ovs_name $tap_name
fi

# Conectar la interfaz TAP al OvS con VLAN
ovs-vsctl add-port $ovs_name $tap_name tag=$vlan_id

echo "Interfaz TAP $tap_name conectada a $ovs_name con VLAN ID $vlan_id."

# Ejecutar la VM
qemu-system-x86_64 \
    -name $vm_name \
    -drive file=$cirros_image,format=qcow2 \
    -m 512 \
    -net nic,model=virtio \
    -net tap,ifname=$tap_name,script=no,downscript=no \
    -vnc :$vnc_port \
    -daemonize

echo "VM $vm_name iniciada con VNC escuchando en el puerto $vnc_port."
echo "Configuración completada."

