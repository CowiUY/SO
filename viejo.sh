letrasGrupos=(a b c d e f g h i j k l m n o p q r s t u v w x y z)


echo $(tput setaf 1)$(tput setab 7) Menú$(tput sgr 0)





#echo ${letrasGrupos[20]}
















echo $ci >> grupos/






echo $numero:1:$ci >> ALUMNOS.DAT
echo $numero:2:$nomcom >> ALUMNOS.DAT
echo $numero:3:$fecha >> ALUMNOS.DAT
echo $numero:4:$telefono >> ALUMNOS.DAT
echo $numero:5:$anoacursar >> ALUMNOS.DAT
echo $numero:6:$pendientes >> ALUMNOS.DAT
echo >> ALUMNOS.DAT




function menu{
	echo Ingrese una opción: #PONGAMOS ALGUN SETAF Y/O SETAB
	echo -e "1 - Agregar estudiante\n"
	echo -e "2 - Buscar estudiante\n"
	echo -e "3 - Borrar estudiante\n"
	echo -e "4 - Modificar estudiante\n"
	echo -e "5 - Informacion relevante del estudiante\n"
	echo -e "6 - Salir\n"
}


agregarAlumno(){
    echo Ingrese los siguientes datos
echo CI
read ci
echo Nombre Completo
read nomcom
echo Fecha de Nacimiento
read fecha
echo Teléfono
read telefono
echo Año a cursar
read anoacursar
echo Cantidad de materias pendientes
read pendientes


if [ -f grupos/$anoacursar/ba ]
then
echo esiste $anoacursar ba

else
mkdir grupos/$anoacursar/
touch grupos/$anoacursar/ba
grupo=ba
echo nosiste $anoacursar ba
fi

#local NOMVAR es una variable local, puede ser accedida SOLO DESDE DONDE SE LA DECLARA
#Cualquier otra variable es 'global' y puede ser accedida desde cualquier lado del código
#Siempre recordando que bash es POR LINEA Y NO COMPILADO, por lo que hay que declarar las cosas antes de llamarlas
if [ -f ALUMNOS.DAT ]
then
echo esiste
numero=$(tail -n 4 ALUMNOS.DAT | head -n 1 | cut -d : -f 1)
echo $numero
numero=$(($numero + 1))
echo $numero

else
echo nosiste
numero=1
echo $numero
fi
}


existeAñoACursar()
{

}