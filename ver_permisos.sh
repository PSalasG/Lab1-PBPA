#!/bin/bash

archivo_path="$1"

if [ -e "archivo_path"  ];then
	echo "Detecto archivo"
	ls -l $archivo_path > $permisos
	echo "$permisos"
	exit 1

exit 0
