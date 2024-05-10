import paramiko
import subprocess

# Configuración de nodos y credenciales
direccion_headnode = "headnode.example.com"
nombre_usuario = "ubuntu"
contraseña_usuario = "ubuntu"
direcciones_workers = ["10.0.0.30", "10.0.0.40", "10.0.0.50"]

# Parámetros de configuración para switches y VLANs
nombre_switch_headnode = "br-int"
nombre_switch_worker = "br-int"
interfaz_headnode = "ens5"
interfaz_worker = "ens4"
configuraciones_vlan = [("10.0.101.0/24", "vlan100", "100", "10.0.101.3,10.0.101.100,255.255.255.0"),("10.0.102.0/24", "vlan200", "200", "10.0.102.3,10.0.102.100,255.255.255.0"), ("10.0.103.0/24", "vlan300", "300", "10.0.103.3,10.0.103.100,255.255.255.0")]
configuraciones_vm = [("100", "vm1", "5901", "br-int"),("200", "vm2", "5902", "br-int"), ("300", "vm3", "5903", "br-int")]

def ejecutar_en_headnode(comando):
    try:
        subprocess.run(comando, shell=True, check=True)
        print(f"### Comando en HeadNode exitoso: {comando}")
    except subprocess.CalledProcessError as error:
        print(f"### Error en HeadNode al ejecutar comando: {error}")

def ejecutar_en_worker(worker, comando):
    ssh_client = paramiko.SSHClient()
    ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    try:
        ssh_client.connect(hostname=worker, username=nombre_usuario, password=contraseña_usuario)
        stdin, stdout, stderr = ssh_client.exec_command(comando, get_pty=True)
        stdin.write(contraseña_usuario + '\n')
        stdin.flush()
        error_output = stderr.read().decode("utf-8")
        output = stdout.read().decode("utf-8")
        if error_output:
            print(f"** Error en {worker}: {error_output.strip()} **")
        else:
            print(f"** Comando en {worker} ejecutado correctamente: {output.strip()} **")
    finally:
        ssh_client.close()

# Ejecución de scripts en el HeadNode
ejecutar_en_headnode(f"bash headnode.sh {nombre_switch_headnode} {interfaz_headnode}")
for config_vlan in configuraciones_vlan:
    ejecutar_en_headnode(f"bash network_headnode.sh {' '.join(config_vlan)}")

# Ejecución de scripts en los Workers
for direccion_worker in direcciones_workers:
    ejecutar_en_worker(direccion_worker, f"sudo -S bash worker.sh {nombre_switch_worker} {interfaz_worker}")

for direccion_worker in direcciones_workers:
    for config_vm in configuraciones_vm:
        ejecutar_en_worker(direccion_worker, f"sudo -S bash create_vm.sh {' '.join(config_vm)}")

for config_vlan in configuraciones_vlan:
    ejecutar_en_headnode(f"bash internet_vlan.sh {config_vlan[2]}")

print("*** Proceso de orquestación completado exitosamente ***")
