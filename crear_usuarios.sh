#!/bin/bash

sudo useradd -m -N $1 2> /dev/null # Creo el ususario sin un grupo propio para no crear grupos innecesarios.

if [ $? = 9 ]; then
	echo "El usuario $1 ya existe"

else
	echo "El usuario $1 fue creado con éxito"
fi

sudo groupadd $2 2> /dev/null # Crea el grupo e imprime la confirmación.

if [ $? = 9 ]; then
        echo "El grupo $2 ya existe"

else
	echo "El grupo $2 fue creado con éxito"
fi

# Añade los usuarios al nuevo grupo.
sudo usermod -a -G $2 $1
sudo usermod -a -G $2 $USER

echo "Los usuarios $1 y $USER fueron añadidos al grupo $2"

#Cambia los permisos del anterior script.
sudo chown :$2 ver_permisos.sh

echo "El archivo ver_permisos.sh solo puede ser ejecutado por miembros del grupo $2"

exit 0
