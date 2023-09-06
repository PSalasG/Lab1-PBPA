#!/bin/bash

archivo="$1"

# Primero revisa si el archivo existe
if [ -f "$archivo" ]; then
	echo "Se encontró el archivo $archivo"
	permisos=$(stat -c %A $archivo)

else
	cd $archivo 2> /dev/null # Si el archivo no existe ejecuta este comando para generar un error y almacenar su código.
	echo "No existe el archivo $archivo, código de error $?"
	exit 1

fi

# Esta función es la que se encarga más adelante de recibir los permisos de cada uno e imprimirlos.
function imprimir_permisos(){
        if [ $1 = "---" ]; then
               echo "$sujeto no tiene ningún permiso del archivo" # En el caso de que no tenga ningún permiso.

        else
               echo "$sujeto tiene permisos de " | tr -d "\n" # Uso el comando tr para que el echo no termine en una nueva linea y así concatenar el resto del texto luego.

               if [ ${1:0:1} = "r" ]; then # Así reviso cada permiso en específico, no se me ocurrió otra mejor forma de hacerlo.
                       echo "leer " | tr -d "\n"
               fi

               if [ ${1:1:1} = "w" ]; then
		       echo "editar " | tr -d "\n"
               fi

               if [ ${1:2:1} = "x" ]; then
                       echo "ejecutar " | tr -d "\n"
               fi

               echo "el archivo"
	fi
	
}

function get_permissions_verbose(){
	for i in {1..7..3}; do # Itera de 3 en 3 en el string de todos los permisos, empezando en 1 para no contar el espacio del tipo de documento, así la primera iteración son los permisos de usuario, la segunda del grupo, y la tercera de los otros usuarios.
		if [ $i = "1" ]; then
			sujeto="El usuario dueño"
			perm_usuario=${1:$i:3}
			imprimir_permisos $perm_usuario

		elif [ $i = "4" ]; then
			sujeto="El grupo dueño" # La variable "sujeto" será usada en la función de imprimir los permisos.
			perm_grupo=${1:$i:3}
			imprimir_permisos $perm_grupo

		else
			sujeto="Otro usuario"
			perm_otros=${1:$i:3}
			imprimir_permisos $perm_otros
			
		fi

	done

}


get_permissions_verbose $permisos


exit 0
