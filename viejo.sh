pepito=8
crearGrupo () {
clear

tput setaf 1

echo Creando Grupo...
#echo $pepito
echo "Ingrese nombre de grupo (En una sola palabra):"
tput sgr 0
read nomGrupo


tput setaf 1
#tput setab 7


echo Ingrese Salón
tput sgr 0
read salon

tput setaf 1
#tput setab 7

echo Ingrese nombre del adscripto
tput sgr 0
read adscripto



if [ $pepito == 1 ]
then
anioGrupo=$anoacursar
orientacion=$oriAlumno
alumnos=1
else
alumnos=0
tput setaf 1
echo Ingrese año del curso
tput sgr 0
tput sgr 0
read anioGrupo


tput setaf 1
echo 'Ingrese Orientación del grupo (cocina o barman)'
tput sgr 0
read orientacion


while [ "$orientacion" != "cocina" ] && [ "$orientacion" != "barman" ]
do
echo orientacion no disponible
echo Ingrese orientacion valida: cocina o barman
read orientacion
done


fi

if [ -f GRUPOS.DAT ]
then

if grep -wq $nomGrupo GRUPOS.DAT
then
clear
echo El grupo ingresado ya existe
echo Estos son sus datos:
echo

#grupoExiste=$(grep $nomGrupo GRUPOS.DAT | cut -d: -f 1)
grep -w $nomGrupo GRUPOS.DAT | cut -d: -f 2,3
if [ $pepito == 1 ]
then
orientacion=$(grep -w $nomGrupo:Orientación GRUPOS.DAT | cut -d: -f 3)
fi

else

echo $nomGrupo:Nombre:$nomGrupo >> GRUPOS.DAT
echo $nomGrupo:Orientación:$orientacion >> GRUPOS.DAT
echo $nomGrupo:Salón:$salon >> GRUPOS.DAT
echo $nomGrupo:Adscripto:$adscripto >> GRUPOS.DAT
echo $nomGrupo:Año:$anioGrupo >> GRUPOS.DAT
echo $nomGrupo:Alumnos:$alumnos >> GRUPOS.DAT

echo >> GRUPOS.DAT
echo >> GRUPOS.DAT

echo Grupo ingresado con éxito
fi

else
echo $nomGrupo:Nombre:$nomGrupo >> GRUPOS.DAT
echo $nomGrupo:Orientación:$orientacion >> GRUPOS.DAT
echo $nomGrupo:Salón:$salon >> GRUPOS.DAT
echo $nomGrupo:Adscripto:$adscripto >> GRUPOS.DAT
echo $nomGrupo:Año:$anioGrupo >> GRUPOS.DAT
echo $nomGrupo:Alumnos:$alumnos >> GRUPOS.DAT

echo >> GRUPOS.DAT
echo >> GRUPOS.DAT

echo Grupo ingresado con éxito
fi






echo Presione enter volver
read fjoweifheow


#menu
}


agregarAlumno () {

	clear

echo Ingrese los siguientes datos
echo CI
read ci
echo Nombre Completo
read nomcom
echo 'Fecha de Nacimiento (dd/mm/yy)'
read fecha
echo Teléfono
read telefono
echo Año a cursar
read anoacursar
echo Cantidad de materias pendientes
read pendientes



if [ $pendientes == 0 ]
then


#if [ grep -wq Año:$anoacursar GRUPOS.DAT ]


echo "¿Quiere ingresarlo a un grupo existente [opcion 1] o crear uno [opcion 2]?"
read opcionGrupo

if [ $opcionGrupo = 1 ]
then
echo Ingrese orientacion del alumno: cocina o barman
read oriAlumno


while [ "$oriAlumno" != "cocina" ] && [ "$oriAlumno" != "barman" ]
do
echo Orientación no disponible
echo Ingrese orientación valida
read oriAlumno
done

agregarGrupoExistente


else
crearGrupo
oriAlumno=$orientacion


fi

grupoAlumno=$nomGrupo

if [ -f ALUMNOS.DAT ]
then
numero=$(tail -n 4 ALUMNOS.DAT | head -n 1 | cut -d : -f 1)
#echo $numero
numero=$(($numero + 1))
#echo $numero

else
numero=1
#echo $numero
fi

echo $grupoAlumno


echo $numero:CI: $ci >> ALUMNOS.DAT
echo $numero:Nombre Completo: $nomcom >> ALUMNOS.DAT
echo $numero:Fecha de Nacimiento: $fecha >> ALUMNOS.DAT
echo $numero:Teléfono: $telefono >> ALUMNOS.DAT
echo $numero:Grupo: $grupoAlumno >> ALUMNOS.DAT
echo $numero:Año a Cursar: $anoacursar >> ALUMNOS.DAT
echo $numero:Asignaturas Pendientes: $pendientes >> ALUMNOS.DAT
echo $numero:Orientación: $oriAlumno >> ALUMNOS.DAT
echo >> ALUMNOS.DAT

#echo Presione enter para ir al menú
#read fjoweifheow


#menu

else

echo El alumno no puede inscribirse porque tiene asignaturas pendientes

echo Presione enter para ir al menú
read fjoweifheow


menu

fi
}

leerAlumnos () {

	clear
        
echo Buscando Alumnos...
echo





cat ALUMNOS.DAT | cut -d: -f2,3

echo Presione enter para ir al menú
read fjoweifheow


#menu
}

alumnoCedula () {

	clear

echo $(tput setaf 1)$(tput setab 7) Ingrese la cédula del alumno a buscar: $(tput sgr 0)
read AlumnoBuscarCi

if grep -w $AlumnoBuscarCi ALUMNOS.DAT
then
clear
echo Resultados de tu búsqueda:
echo
numAlumnoCI=$(grep $AlumnoBuscarCi ALUMNOS.DAT | cut -d: -f 1)
grep -w $numAlumnoCI ALUMNOS.DAT | cut -d: -f 2,3
echo

else
echo La cédula ingresada no existe
fi



echo Presione enter para ir al menú
read fjoweifheow

menu
}




menu () {




while [ $pepito -ne 0 ]
do

clear
echo $(tput setaf 1)$(tput setab 7) Menú$(tput sgr 0)

        echo Ingrese una opción: #PONGAMOS ALGUN SETAF Y/O SETAB
        echo 1- Ingresar Alumno
        echo 2- Ingresar Grupo
        echo 3- Leer Alumnos
        echo 4- Leer Grupos
        echo 5- Borrar Alumno
        echo 6- Borrar Grupo
        echo 7- Cambiar Teléfono de un Alumno
        echo 8- Buscar Alumno por cédula
        echo 0- Salir
#       agregarAlumno()


read pepito

#echo $pepito

case $pepito in
1) agregarAlumno ;;
2) crearGrupo ;;
3) leerAlumnos ;;
4) listadoGrupos ;;
5) borrarAlumno ;;
6) borrarGrupo ;;
7) cambiarTelefono ;;
8) alumnoCedula ;;
0) ;;
esac

done
}

agregarGrupoExistente () {
echo
echo
echo

echo Grupos de $anoacursar año
echo
#grep -w Año GRUPOS.DAT | cut -d: -f 1,3 | grep $anoacursar
if grep -w Año GRUPOS.DAT | grep $anoacursar
then
echo

echo Ingrese el nombre del grupo al que quiere agregar al alumno:
	read nomGrupo
	echo
	echo

if [ -f GRUPOS.DAT ]
then

if grep -wq $nomGrupo GRUPOS.DAT
then

grep -w $nomGrupo GRUPOS.DAT | cut -d: -f 2,3

cuposAgregarGrupo=$(grep -w $nomGrupo GRUPOS.DAT | tail -n 1 | cut -d: -f 3)

echo
echo El curso tiene $cuposAgregarGrupo alumnos

if [ $cuposAgregarGrupo -lt 15 ]
then
echo '¿Confirma que quiere agregar al alumno al grupo '$nomGrupo'? (s o n)'
read opcionUsuario

if [ $opcionUsuario == s ]
then
lineacupos=$(grep -n $nomGrupo GRUPOS.DAT | tail -n 1 | cut -d: -f 1)

cuposACambiar=$(grep $nomGrupo GRUPOS.DAT | tail -n 1 | cut -d: -f 1,2):

cuposfinales=$(($cuposAgregarGrupo+1))


sed -i "/$(grep $nomGrupo GRUPOS.DAT | tail -n 1)/c $cuposACambiar$cuposfinales" GRUPOS.DAT


echo Presione enter para ir al menú
read fhodfhoeiwhfiowehfiowehfioehf
else
agregarGrupoExistente
fi



else
echo El grupo ya cuenta con 15 alumnos, no se pueden agregar más
echo ¿Quiere probar con otro grupo [1] o volver al menú[2]?

read opcionUsuario

if [ $opcionUsuario == 1 ]
then
agregarGrupoExistente
else
menu
fi
fi


else

echo El grupo ingresado no existe

echo ¿Quiere volver a intentarlo [1] o ir al menu[2]?
read opcionUsuario

if [ $opcionUsuario == 1 ]
then
agregarGrupoExistente
else
menu
fi

fi

else
echo Usted no ha creado ningún grupo
echo Tiene que ir al menú y crear al menos uno
echo Presione enter para ir al menú 345
read fhodfhoeiwhfiowehfiowehfioehf

fi

else
echo Usted no tiene grupos para $anoacursar año.
echo Crear Grupo [1] Volver al Menú [2]
read opcionUsuario

if [ $opcionUsuario == 1 ]
then
crearGrupo
#else
#menu
fi
fi
}

cambiarTelefono () {
        echo Ingrese la cédula del alumno
        read ci
        #grep -w $ci: ALUMNOS.DAT
        #grep -v $ci: ALUMNOS.DAT
        
        
        numeroAlumno=$(grep $ci ALUMNOS.DAT | cut -d: -f1)
# ESTO VA DESPUES, DEBUG                        clear


#telefonoViejoLinea=$(grep $numeroAlumno:Teléfono: GRUPOS.DAT)

echo Ingrese nuevo número telefónico:
read telefonoNuevo

        sed -i "/$(grep $numeroAlumno:Teléfono: ALUMNOS.DAT)/c $numeroAlumno:Teléfono: $telefonoNuevo" ALUMNOS.DAT
        #sed -i "s/$numeroAlumno:Teléfono/$numeroAlumno:Teléfono:$telefonoNuevo" ALUMNOS.DAT

echo
echo Así quedan los datos del alumno:
echo

        grep $numeroAlumno: ALUMNOS.DAT | cut -d: -f2,3
echo
echo Presione enter para volver al menú
read fhodfhoeiwhfiowehfiowehfioehf
}

listadoGrupos () {
clear
cat GRUPOS.DAT | cut -d: -f2,3

echo Presione enter para ir al menú
read fjoweifheow

}

borrarAlumno () {
        clear
        echo Introduzca la cédula del alumno a borrar
        read cedulaBorrar

if grep -w $cedulaBorrar ALUMNOS.DAT
then
echo El alumno existe...

numeroAlumnoBorrar=$(grep -w $cedulaBorrar ALUMNOS.DAT | cut -d: -f1)
        echo $numeroAlumnoBorrar
#echo TERMINA NUMERO 
        grupoAlumno=$(grep $numeroAlumnoBorrar:Grupo ALUMNOS.DAT | cut -d: -f3)
        echo $grupoAlumno
   #     echo TERMINA GRUPOALUMNO

        cuposAgregarGrupo=$(grep $grupoAlumno GRUPOS.DAT | tail -n 1 | cut -d: -f3)
    cuposFinales=$(($cuposAgregarGrupo-1))

    echo Quedaban $cuposAgregarGrupo y ahora quedan $cuposFinales, el grupo del alumno es $grupoAlumno
    echo Y el número del alumno es $numeroAlumnoBorrar

    #grep -w $numeroAlumnoBorrar ALUMNOS.DAT
    echo
    echo
    #grep -w $grupoAlumno GRUPOS.DAT

        if sed -i "/$numeroAlumnoBorrar:/d" ALUMNOS.DAT
        then
        #clear
        echo
echo
cat ALUMNOS.DAT
        echo Borrado con éxito
        
        sed -i "/$(grep $grupoAlumno GRUPOS.DAT | tail -n 1)/c $grupoAlumno:Alumnos:$cuposFinales" GRUPOS.DAT
echo
echo
cat ALUMNOS.DAT

        echo Presione enter para ir al menú
        read fjoweifheow
        else
        #clear
        echo Hubo un problema
        echo ¿Está seguro que ese alumno existe?
        echo
        echo Presione enter para ir al menú
        read fjoweifheow
        fi




else
echo Ingresó una cédula no válida
echo
echo Presione enter para volver al menú
read fhodfhoeiwhfiowehfiowehfioehf

fi


        
}

borrarGrupo () {
    clear
        echo ¿Quiere ver los grupos [1] o borrar directamente [nombre de grupo]?
        read opcionUsuario

        if [ $opcionUsuario == 1 ]
then

cat GRUPOS.DAT | cut -d: -f2,3

echo Presione enter para continuar
read fhodfhoeiwhfiowehfiowehfioehf
borrarGrupo
else

        if grep -w $opcionUsuario GRUPOS.DAT
        then

        alumnosGrupoBorrar=$(grep -w $opcionUsuario GRUPOS.DAT | tail -n 1 | cut -d: -f 3)
        echo $alumnosGrupoBorrar

        


        if [ $alumnosGrupoBorrar -ne 0 ]
        then
        #clear
        echo El grupo sigue teniendo alumnos, no se puede borrar
        echo
        echo Presione enter para ir al menú
        read fjoweifheow
        else
        #clear
        echo El curso no tiene alumnos, borrando...

        sed -i "/$opcionUsuario/d" GRUPOS.DAT
        echo
        echo Presione enter para ir al menú
        read fjoweifheow
        fi

        else
        echo El grupo ingresado no existe
        echo
        echo Presione enter para volver al menú
        read fhodfhoeiwhfiowehfiowehfioehf
fi


fi


        
        
}


menu