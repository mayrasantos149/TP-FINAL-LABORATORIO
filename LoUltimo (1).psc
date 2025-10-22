Proceso TerminalAutogestion
    // VARIABLES 
    // ==============
    Definir asientos, pasajerosDestino, pasajerosAsiento, TotaldePasajeros, ventasPorDestino, opc Como Entero;
    Definir destinos, pasajerosNombre, pasajerosDNI, pasajerosCodigoQR, pasajerosFecha, fechasDisponibles Como Caracter;
    Definir pasajerosPago Como Real;
    Definir pasajerosPagado, auth Como Logico;
	
    Dimension destinos[6,4];
    Dimension asientos[6,40]; 
    Dimension pasajerosNombre[100];
    Dimension pasajerosDNI[100];
    Dimension pasajerosDestino[100];
    Dimension pasajerosAsiento[100];
    Dimension pasajerosPago[100];
    Dimension pasajerosPagado[100];
    Dimension pasajerosCodigoQR[100];
    Dimension pasajerosFecha[100];
    Dimension fechasDisponibles[6,10];
    Dimension ventasPorDestino[6];
	
	//grafico
	Escribir "..................................................................";
	Escribir "............................_#^^#_................................";
	Escribir "...........................#^....^#...............................";
	Escribir "..........................#^..__..^#..............................";
	Escribir "........................._#._#^^#_.#_.............................";
	Escribir ".........................#..^....^..#.............................";
	Escribir "..................._#^#..#..........#..#^#_.......................";
	Escribir "...................#..##_#..........#_##..#.......................";
	Escribir "..............___..#__##^#..........#^##__#..___..................";
	Escribir ".............#..##_#^^...#..........#...^^#_##..#.................";
	Escribir ".............#__#^^......#..........#......^^#__#.................";
	Escribir "............_#^^.........#_........_#.........^^#_................";
	Escribir "............#^....._____####........####_____......#..............";
	Escribir "...........#___#^^^......##........##......^^^#___#...............";
	Escribir "............^^............##........##..........^^................";
	Escribir "...........................#........#.............................";
	Escribir "...........................#........#.............................";
	Escribir "...........................#__#^^#__#.............................";
	Escribir "........................__#^^......^^#__..........................";
	Escribir "......................_#^...___##___...^#_........................";
	Escribir "......................#_____#^....^#_____#........................"; 
	Escribir "";
	Escribir "######\\    #######  ######\    /######|    ####    #\     ##   ++";
	Escribir "##     \#   ##       ##    \#  ##         ##   ##   ##\    ##   ++";
	Escribir "##     /#   ##       ##    /#  ##        ##     ##  # #\   ##   ++";
	Escribir "######//    #####    ######/    #####\   #########  ## #\  ##   ++";
	Escribir "##          ##       ##  #\          ##  ##     ##  ##  #\ ##   ++";
	Escribir "##          ##       ##   #\         ##  ##     ##  ##   #\##   ++";
	Escribir "##          #######  ##    #\  |######/  ##     ##  ##    #\#   ++";
	Escribir "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++";
	Esperar 7 segundos;
	Limpiar Pantalla;
	
	
    // Inicializar
    InicializarSistema(destinos, asientos, ventasPorDestino, TotaldePasajeros, pasajerosDNI, pasajerosCodigoQR, fechasDisponibles, pasajerosPago, pasajerosDestino);	
    
    // MENU PRINCIPAL DE USUARIOS
    Repetir
        Escribir "===========================================";
        Escribir "    TERMINAL DE AUTOGESTI�N DE PASAJES";
        Escribir "===========================================";
        Escribir "1. Cliente";
        Escribir "2. Administrador";
        Escribir "3. Salir";
        Escribir "-------------------------------------------";
		
        // Lectura validada (evita letras/signos/vac�o)
        opc <- LeerNumeroEnRango("Seleccione su tipo de usuario: ", 1, 3, 2);
        
        Segun opc Hacer
            1:
                Escribir "Acceso como CLIENTE";
                MenuCliente(destinos, asientos, pasajerosNombre, pasajerosDNI, pasajerosDestino, pasajerosAsiento, pasajerosPago, pasajerosPagado, pasajerosCodigoQR, ventasPorDestino, TotaldePasajeros, fechasDisponibles, pasajerosFecha);               
            2:
                Escribir "Acceso como ADMINISTRADOR";
                auth <- AutenticarAdmin();
                Si auth Entonces
                    MenuAdministrador(destinos, asientos, pasajerosNombre, pasajerosDNI, pasajerosDestino, pasajerosAsiento, pasajerosPago, pasajerosPagado, pasajerosCodigoQR, ventasPorDestino, TotaldePasajeros, pasajerosFecha);
                FinSi;
            3:
                Escribir "�Hasta pronto!";
            De Otro Modo:
                Escribir "Opci�n no v�lida. Intente nuevamente.";
        FinSegun
    Hasta Que opc = 3;
FinProceso


// SUBPROCESOS

// ======= VALIDACIONES B�SICAS =======

// QuitarEspacios 
Funcion texto_sin_espacios <- QuitarEspacios(texto_ingresado)
    Definir inicio, ultimo Como Entero;
    Definir ch Como Caracter;
    inicio <- 0;
    ultimo <- Longitud(texto_ingresado) - 1;
	
    // quitar espacios al inicio
    Mientras inicio <= ultimo Y Subcadena(texto_ingresado, inicio, inicio) = " " Hacer
        inicio <- inicio + 1;
    FinMientras
	
    // quitar espacios al final
    Mientras ultimo >= inicio Y Subcadena(texto_ingresado, ultimo, ultimo) = " " Hacer
        ultimo <- ultimo - 1;
    FinMientras
	
    Si ultimo < inicio Entonces
        texto_sin_espacios <- "";
    SiNo
        texto_sin_espacios <- Subcadena(texto_ingresado, inicio, ultimo);
    FinSi
FinFuncion


// TieneSoloDigitos
Funcion es_valido <- TieneSoloDigitos(texto_ingresado)
    Definir i Como Entero;//posicion de donde miro
    Definir caracterActual Como Caracter;
    texto_ingresado <- QuitarEspacios(texto_ingresado);  //le quita espacios
    es_valido <- (Longitud(texto_ingresado) > 0); //si su long >0  se hace true
    Para i <- 0 Hasta Longitud(texto_ingresado)-1 Hacer
        caracterActual <- Subcadena(texto_ingresado, i, i);//recorre del 0 al 9 , todos los i
        Si No (caracterActual >= "0" Y ch <= "9") Entonces
            es_valido <- Falso;
        FinSi
    FinPara
FinFuncion
// DejarSoloDigitos 
Funcion solo_numeros <- DejarSoloDigitos(texto_ingresado) //filtra todo lo q no sea digitos
    Definir i Como Entero;
    Definir caracterActual Como Caracter;
    solo_numeros <- "";//aca se guardaran solo los NUMEROS,es un acum  como cadena vacia
    Para i <- 0 Hasta Longitud(texto_ingresado)-1 Hacer
        caracterActual <- Subcadena(texto_ingresado, i, i);//saca el caracter en cada i(posicion)
        Si caracterActual >= "0" Y caracterActual <= "9" Entonces//mira si hay nros del 1 al 9 si no no lo guarda en solo_numeros
            solo_numeros <- solo_numeros + caracterActual;
        FinSi
    FinPara
FinFuncion

// ======= LECTURAS SEGURAS =======
// numeros entre tal y tal 
Funcion numer <- LeerNumeroEnRango(mensaje, minimo, maximo, largo_max)
    Definir ok Como Logico;
    Definir entrada Como Caracter;
    Definir valores Como Entero;
    Repetir
        Escribir Sin Saltar mensaje;//muestra el mensaje
        Leer entrada;
        entrada <- QuitarEspacios(entrada);//le quita los espacioss
        ok <- (Longitud(entrada) > 0 Y Longitud(entrada) <= largo_max Y TieneSoloDigitos(entrada));//q no este vaacio, q el largo sea menor al maximo, y q solo tenga digitos
        Si ok Entonces
            valores <- ConvertirANumero(entrada);
            ok <- (valores >= minimo Y valores <= maximo);//q este dentro de este rango
        FinSi
        Si No ok Entonces
            Escribir "Inv�lido. Ingres� un n�mero entre ", minimo, " y ", maximo, ".";
        FinSi
    Hasta Que ok//si falla algo lo vuelve  a pedir
    numer <- valores;
FinFuncion


Funcion dni <- LeerDNIValido // funcion sin parametrps
    Definir entrada, limpio Como Caracter;
    Definir ok Como Logico;
	
    Repetir
        Escribir Sin Saltar "DNI (8 d�gitos): ";
        Leer entrada;
        entrada <- QuitarEspacios(entrada);//quita espacios
        limpio <- DejarSoloDigitos(entrada)  ; // quita puntos,guiones
        ok <- (Longitud(limpio) = 8);//al final solo tiene q tener  8 digitos
        Si No ok Entonces // si no pasa eso le tiro un mensaje
            Escribir "DNI inv�lido: deben ser exactamente 8 d�gitos.";
        FinSi
    Hasta Que ok //repite hasta q no sea verdadero
    dni <- limpio;
FinFuncion

// [AGREGADO]
Funcion respuesta <- LeerConfirmacionSN(mensaje)
    Definir entrada Como Caracter;
    Repetir
        Escribir Sin Saltar mensaje, " (S/N): ";//escribe mensaje y pide confimacion 
        Leer entrada;
        entrada <- Mayusculas(QuitarEspacios(entrada));//quita espacio y pasa todo a mayuscula
    Hasta Que entrada = "S" O entrada = "N"
    respuesta <- entrada;
FinFuncion

Funcion nombre <- LeerNombreValido(mensaje)
    Definir entrada, caracterActual Como Caracter;
    Definir i Como Entero;
    Definir ok Como Logico;
	
    Repetir
        Escribir Sin Saltar mensaje;
        Leer entrada;
        entrada <- QuitarEspacios(entrada);
		
        ok <- (Longitud(entrada) > 0);
        Si ok Entonces
            ok <- Verdadero;
            Para i <- 0 Hasta Longitud(entrada)-1 Hacer
				caracterActual<- Subcadena(entrada, i, i);  // <- obtener 1 car�cter
                // inv�lido si NO es letra (A-Z/a-z) NI espacio
                Si No ( (caracterActual >= "A" Y caracterActual <= "Z") O (caracterActual >= "a" Y caracterActual <= "z") O (caracterActual = " ") ) Entonces
                    ok <- Falso;
                FinSi
            FinPara
        FinSi
		
        Si No ok Entonces
            Escribir "Nombre inv�lido (solo letras y espacios).";
        FinSi
    Hasta Que ok
	
    nombre <- entrada;
FinFuncion


// Busca si un DNI ya existe en el arreglo 
Funcion existe <- DniExiste(pasajerosDNI, totalPasajeros, dniBuscado)
    Definir i Como Entero;
    existe <- Falso;
	
    // ojo: usar <= y >= ASCII,
    Si totalPasajeros > 0 Entonces
        Para i <- 0 Hasta totalPasajeros - 1 Hacer
            Si pasajerosDNI[i] = dniBuscado Entonces
                existe <- Verdadero;
            FinSi
        FinPara
    FinSi
FinFuncion

// =======================
// INICIALIZACI�N
// =======================
SubProceso InicializarSistema(destinos, asientos, ventasPorDestino, TotaldePasajeros Por Referencia, pasajerosDNI, pasajerosCodigoQR, fechasDisponibles, pasajerosPago, pasajerosDestino)
    Definir i, j Como Entero;
    
    // Destinos, matriz de textp 
    destinos[0,0] = "1"; destinos[0,1] = "BUENOS AIRES"; destinos[0,2] = "JUJUY"; destinos[0,3] = "15000";
    destinos[1,0] = "2"; destinos[1,1] = "BUENOS AIRES"; destinos[1,2] = "SANTA CRUZ"; destinos[1,3] = "18000";
    destinos[2,0] = "3"; destinos[2,1] = "BUENOS AIRES"; destinos[2,2] = "MISIONES"; destinos[2,3] = "12000";
    destinos[3,0] = "4"; destinos[3,1] = "JUJUY"; destinos[3,2] = "BUENOS AIRES"; destinos[3,3] = "15000";
    destinos[4,0] = "5"; destinos[4,1] = "SANTA CRUZ"; destinos[4,2] = "BUENOS AIRES"; destinos[4,3] = "18000";
    destinos[5,0] = "6"; destinos[5,1] = "MISIONES"; destinos[5,2] = "BUENOS AIRES"; destinos[5,3] = "12000";
    
    // Fechas disponibles 
    Para i <- 0 Hasta 5 Hacer
        //  Consistencia de may�sculas
        fechasDisponibles[i,0] <- ConvertirATexto(Aleatorio(1,30)) + "/11/2025"; 
    FinPara
    
    // Asientos (todos libres)matriz numerica
    Para i <- 0 Hasta 5 Hacer
        Para j <- 0 Hasta 39 Hacer
            asientos[i,j] <- 0;
        FinPara
    FinPara
    
    // Ventas y pasajeros LIBRE
    Para i <- 0 Hasta 5 Hacer
        ventasPorDestino[i] <- 0;
    FinPara
	//datos del pasajero VACIIO
    Para i <- 0 Hasta 99 Hacer
        pasajerosDNI[i] <- "";
        pasajerosCodigoQR[i] <- "";
        pasajerosPago[i] <- 0; 
        pasajerosDestino[i] <- 0;
    FinPara
    TotaldePasajeros <- 0;
FinSubProceso


// =======================
// LOGIN ADMIN
// =======================
SubProceso accesoAdmin <- AutenticarAdmin//corrobora si puede entrar o no 
    Definir accesoAdmin Como Logico;
    //  Tipo correcto
    Definir usuario, clave Como Caracter;
    
    accesoAdmin <- Falso;
    Escribir "-------------------------------------------";
    Escribir "INGRESO ADMINISTRADOR";
    Escribir Sin Saltar "Usuario: ";
    Leer usuario;
    Escribir Sin Saltar "Contrase�a: ";
    Leer clave;
    
    Si usuario = "admin" Y clave = "1234" Entonces
        accesoAdmin <- Verdadero;
        Escribir "�Acceso concedido!";
    Sino
        Escribir "Credenciales incorrectas.";
    FinSi
FinSubProceso


// =======================
// MEN� ADMIN
// =======================
SubProceso MenuAdministrador(destinos, asientos, pasajerosNombre, pasajerosDNI, pasajerosDestino, pasajerosAsiento, pasajerosPago, pasajerosPagado, pasajerosCodigoQR, ventasPorDestino, TotaldePasajeros Por Referencia, pasajerosFecha)
    Definir opc Como Entero;
    
    Repetir
        Escribir "===========================================";
        Escribir "          MEN� ADMINISTRADOR";
        Escribir "===========================================";
        Escribir "1. Ver balance de transporte";
        Escribir "2. Ver estado de los asientos";
        Escribir "3. Ver lista de pasajeros";
        Escribir "4. Volver al men� principal";
        Escribir "-------------------------------------------";
        
        opc <- LeerNumeroEnRango("Seleccione una opci�n: ", 1, 4, 2);// validacion 
        
        Segun opc Hacer
            1: 
                BalanceTransporte(destinos, ventasPorDestino, pasajerosDestino, pasajerosPago, TotaldePasajeros);
            2: 
                EstadoAsientos(destinos, asientos);
            3: 
                Escribir "Listado de pasajeros";
                ListaPasajeros(pasajerosNombre, pasajerosDNI, pasajerosDestino, pasajerosAsiento, pasajerosPago, pasajerosPagado, pasajerosCodigoQR, destinos, TotaldePasajeros, pasajerosFecha);
            4: Escribir "Volviendo...";
            De Otro Modo: Escribir "Opci�n no v�lida.";
        FinSegun
    Hasta Que opc = 4;
FinSubProceso


// imprime matriz de asientos
SubProceso ImprimirMatrizAsientos(asientos, destinoElegido)
    Definir i, j, asientoActual Como Entero;
    
    Escribir "MAPA DEL AVI�N (O=libre / X=ocupado)";
    Escribir "         ______";
    Escribir "       /        \ ";
    Escribir "     /           \ ";
    Escribir "    /A  B     C  D\ ";
    
    Para i <- 0 Hasta 9 Hacer
        Si i = 9 Entonces//las filas  hasta el 9
            Escribir Sin Saltar "F", (i+1), " ";
        SiNo
            Escribir Sin Saltar "F", (i+1), "  ";//este es el 10 , tiene un espacio mas
        FinSi
        
        // Lado izquierdo
        Para j <- 0 Hasta 1 Hacer//fila A a la B
            asientoActual <- i*4 + j;
            Si asientos[destinoElegido, asientoActual] = 0 Entonces
                Escribir Sin Saltar "[O]";
            Sino
                Escribir Sin Saltar "[X]";
            FinSi
        FinPara
        
        Escribir Sin Saltar " | " ;// Pasillo;
        
        // Lado derecho
        Para j <- 2 Hasta 3 Hacer//fila C a D
            asientoActual <- i*4 + j;
            Si asientos[destinoElegido, asientoActual] = 0 Entonces
                Escribir Sin Saltar "[O]";
            Sino
                Escribir Sin Saltar "[X]";
            FinSi
        FinPara
        
        Escribir "";
    FinPara
    Escribir "     \           /";
    Escribir "      \         /";
FinSubProceso


SubProceso EstadoAsientos(destinos, asientos)
    Definir opc, destinoElegido, i, j, asientoActual, ocupados, vacios Como Entero;
    Definir porcentajeOcupacion Como Real;
    
    Repetir
        // Men� de selecci�n de destino
        Escribir "===========================================";
        Escribir "        ESTADO DE ASIENTOS - MEN�";
        Escribir "===========================================";
        Escribir "Seleccione el destino a visualizar:";
        Para i <- 0 Hasta 5 Hacer
            Escribir (i+1), ". ", destinos[i,1], " -> ", destinos[i,2];//MUESTRA destinos
        FinPara
        Escribir "7. Volver al men� anterior";
        Escribir "-------------------------------------------";
        Escribir Sin Saltar "Seleccione una opci�n: ";
        // [CAMBIO] Lectura validada
        opc <- LeerNumeroEnRango("Seleccione una opci�n: ", 1, 7, 2);//valida
        
        Si opc >= 1 Y opc <= 6 Entonces
            destinoElegido <- opc - 1;
            // Contar asientos ocupados y vac�os
            ocupados <- 0;
            vacios <- 0;
            
            Para i <- 0 Hasta 39 Hacer
                Si asientos[destinoElegido, i] = 1 Entonces
                    ocupados <- ocupados + 1;
                Sino
                    vacios <- vacios + 1;
                FinSi
            FinPara
            
            // porcentaje con reales
            porcentajeOcupacion <- (ocupados / 40.0) * 100;
            
            // Mostrar matriz de asientos
            Escribir "";
            Limpiar Pantalla;
            Escribir "===========================================";
            Escribir "    ESTADO DE ASIENTOS - ", destinos[destinoElegido,1], " -> ", destinos[destinoElegido,2];
            Escribir "===========================================";
            ImprimirMatrizAsientos(asientos, destinoElegido);
            
            // Mostrar estad�sticas
            Escribir "===========================================";
            Escribir "ESTAD�STICAS DE OCUPACI�N:";
            Escribir "-------------------------------------------";
            Escribir "Total de asientos:  ", 40;
            Escribir "Asientos ocupados: ", ocupados;
            Escribir "Asientos vac�os:   ", vacios;
            Escribir "Ocupaci�n: ", Redon(porcentajeOcupacion), "%";
            
            Escribir "===========================================";
            Escribir "Presione cualquier tecla para continuar...";
            Esperar Tecla;
            
        Sino 
            Si opc = 7 Entonces
                Esperar 1 Segundos;
                Escribir "Volviendo al men� anterior...";
                Limpiar Pantalla;
            Sino
                Escribir "Opci�n no v�lida. Intente nuevamente.";
            FinSi
        FinSi
    Hasta Que opc = 7;
FinSubProceso


SubProceso BalanceTransporte(destinos, ventasPorDestino, pasajerosDestino, pasajerosPago, TotaldePasajeros)
    Definir i, j, destinoIdx, totalVendidos, destinoMasVendido, maxVentas Como Entero;
    Definir totalRecaudado, promedioVenta, recaudacionPorDestino Como Real;
    Definir porcentajeVentas Como Real;
    //todo desde cero
    totalVendidos <- 0;
    totalRecaudado <- 0;
    maxVentas <- 0;
    destinoMasVendido <- 0;
    i <- 0;
    j <- 0;
    
    Si TotaldePasajeros > 0 Entonces//si hay pasajeros se muestra el balance
        // Calcular totales
        Para i <- 0 Hasta 5 Hacer
            totalVendidos <- totalVendidos + ventasPorDestino[i];//se acumula las ventas x destino
            Si ventasPorDestino[i] > maxVentas Entonces
                maxVentas <- ventasPorDestino[i];//guardo el indice y veo quien tiene maxim de ventas
                destinoMasVendido <- i;
            FinSi
        FinPara
        
        // Calcular recaudaci�n total
        Para i <- 0 Hasta TotaldePasajeros-1 Hacer
            totalRecaudado <- totalRecaudado + pasajerosPago[i];//suma lo q pagaron x el boletp
        FinPara
        
        // Calcular promedio
        Si totalVendidos > 0 Entonces
            promedioVenta <- totalRecaudado / totalVendidos;
            promedioVenta <- Redon(promedioVenta);
        Sino
            promedioVenta <- 0;
        FinSi
        
        // Mostrar balance general
        Limpiar Pantalla;
        Escribir "===========================================";
        Escribir "          BALANCE DE TRANSPORTE";
        Escribir "===========================================";
        Escribir "-------------------------------------------";
        Escribir "ESTAD�STICAS GENERALES:";
        Escribir "-------------------------------------------";
        Escribir "Total de pasajes vendidos: ", totalVendidos;
        Escribir "Total recaudado: $", totalRecaudado;
        Escribir "Promedio por pasaje: $", promedioVenta;
        Escribir "Pasajeros en sistema: ", TotaldePasajeros;
        Escribir "";
        
        // Mostrar ventas por destino
        Escribir "-------------------------------------------";
        Escribir "VENTAS POR DESTINO:";
        Escribir "-------------------------------------------";
        Para i <- 0 Hasta 5 Hacer
            Si totalVendidos > 0 Entonces
                porcentajeVentas <- (ventasPorDestino[i] / totalVendidos) * 100;
            Sino
                porcentajeVentas <- 0;
            FinSi
            
            // Calcular recaudaci�n por destino
            recaudacionPorDestino <- 0;
            Para j <- 0 Hasta TotaldePasajeros-1 Hacer
                Si pasajerosDestino[j] = i Entonces
                    recaudacionPorDestino <- recaudacionPorDestino + pasajerosPago[j];
                FinSi
            FinPara
            
            Escribir destinos[i,1], " -> ", destinos[i,2], ":";
            Escribir "Pasajes: ", ventasPorDestino[i], " (", Redon(porcentajeVentas), "%)";
            Escribir "Recaudaci�n: $", recaudacionPorDestino;
            Escribir "";
        FinPara
        
        // Mostrar destino m�s vendido
        Escribir "-------------------------------------------";
        Escribir "DESTINO M�S POPULAR:";
        Escribir "-------------------------------------------";
        Si maxVentas > 0 Entonces
            Escribir destinos[destinoMasVendido,1], " -> ", destinos[destinoMasVendido,2];
            Escribir "Con ", maxVentas, " pasajes vendidos";
            
            // Mostrar porcentaje del destino m�s vendido
            Si totalVendidos > 0 Entonces
                porcentajeVentas <- (maxVentas / totalVendidos) * 100;
                Escribir "Representa el ", Redon(porcentajeVentas), "% de las ventas totales";
            FinSi
        Sino
            Escribir "No hay ventas registradas";
        FinSi
        
        // An�lisis de ocupaci�n
        Escribir "";
        Escribir "-------------------------------------------";
        Escribir "AN�LISIS DE OCUPACI�N:";
        Escribir "-------------------------------------------";
        Si totalVendidos > 0 Entonces
            // [CAMBIO] Real en denominador
            Escribir "Tasa de ocupaci�n general: ", Redon((totalVendidos / (6 * 40.0)) * 100), "%";
            
            // Encontrar destino con mejor y peor ocupaci�n
            Definir mejorOcupacion, peorOcupacion Como Real;
            Definir idxMejor, idxPeor Como Entero;
            mejorOcupacion <- 0;
            peorOcupacion <- 100;
            idxMejor <- 0;
            idxPeor <- 0;
            
            Para i <- 0 Hasta 5 Hacer
                porcentajeVentas <- (ventasPorDestino[i] / 40.0) * 100;
                
                Si porcentajeVentas > mejorOcupacion Entonces
                    mejorOcupacion <- porcentajeVentas;
                    idxMejor <- i;
                FinSi
                
                Si porcentajeVentas < peorOcupacion Entonces
                    peorOcupacion <- porcentajeVentas;
                    idxPeor <- i;
                FinSi
            FinPara
            
            Escribir "Mejor ocupaci�n: ", destinos[idxMejor,1], " -> ", destinos[idxMejor,2];
            Escribir "  (", Redon(mejorOcupacion), "% de asientos vendidos)";
            Escribir "Menor ocupaci�n: ", destinos[idxPeor,1], " -> ", destinos[idxPeor,2];
            Escribir "  (", Redon(peorOcupacion), "% de asientos vendidos)";
        FinSi
        
        Escribir "===========================================";
        Escribir "Presione cualquier tecla para continuar...";
        Esperar Tecla;
        Limpiar Pantalla;
    Sino
        Limpiar Pantalla;
        Escribir "-------------------------------------------";
        Escribir "No es posible mostrar balance, no se registraron datos...";
    FinSi
FinSubProceso


// =======================
// LISTA DE PASAJEROS
// =======================
SubProceso ListaPasajeros(pasajerosNombre, pasajerosDNI, pasajerosDestino, pasajerosAsiento, pasajerosPago, pasajerosPagado, pasajerosCodigoQR, destinos, TotaldePasajeros Por Referencia, pasajerosFecha)
    Definir i, destinoIdx Como Entero;
    
    Limpiar Pantalla;
    Escribir "===========================================";
    Escribir "           LISTA DE PASAJEROS";
    Escribir "===========================================";
    
    Si TotaldePasajeros = 0 Entonces
        Escribir "No hay pasajeros registrados en el sistema.";
    Sino
        Para i <- 0 Hasta TotaldePasajeros - 1 Hacer
            destinoIdx <- pasajerosDestino[i];
            Escribir "-------------------------------------------";
            Escribir "Pasajero N� ", (i+1);
            Escribir "Nombre: ", pasajerosNombre[i];
            Escribir "DNI: ", pasajerosDNI[i];
            Escribir "Destino: ", destinos[destinoIdx,1], " -> ", destinos[destinoIdx,2];
            Escribir "Fecha: ", pasajerosFecha[i];
            Escribir "Asiento (n�mero interno): ", (pasajerosAsiento[i] + 1);
            Escribir "Precio: $", pasajerosPago[i];
            Si pasajerosPagado[i] Entonces
                Escribir "Estado: PAGADO";
                Escribir "C�digo QR: ", pasajerosCodigoQR[i];
            Sino
                Escribir "Estado: PENDIENTE DE PAGO";
            FinSi
        FinPara
    FinSi
    
    Escribir "===========================================";
FinSubProceso


// =======================
// MEN� CLIENTE
// =======================
SubProceso MenuCliente(destinos, asientos, pasajerosNombre, pasajerosDNI, pasajerosDestino, pasajerosAsiento, pasajerosPago, pasajerosPagado, pasajerosCodigoQR, ventasPorDestino, TotaldePasajeros Por Referencia, fechasDisponibles, pasajerosFecha)    
    Definir opc1 Como Entero;
    Repetir
        Escribir "===========================================";
        Escribir "            MEN� CLIENTE";
        Escribir "===========================================";
        Escribir "1. Comprar pasaje";
        Escribir "2. Control de ticket";
        Escribir "3. Cancelaciones";
        Escribir "4. Partidas";
        Escribir "5. Volver al men� principal";
        Escribir "-------------------------------------------";
        
        // [CAMBIO] Lectura validada
        opc1 <- LeerNumeroEnRango("Seleccione una opci�n: ", 1, 5, 2);
        
        Segun opc1 Hacer
            1:
                Escribir "Compra de pasaje";
                ComprarPasaje(destinos, asientos, pasajerosNombre, pasajerosDNI, pasajerosDestino, pasajerosAsiento, pasajerosPago, pasajerosPagado, pasajerosCodigoQR, ventasPorDestino, TotaldePasajeros, pasajerosFecha, fechasDisponibles);                
            2:  
                Escribir "Control de ticket";
                ControlTicket(destinos, asientos, pasajerosNombre, pasajerosDNI, pasajerosDestino, pasajerosAsiento, pasajerosPago, pasajerosPagado, pasajerosCodigoQR, ventasPorDestino, TotaldePasajeros, pasajerosFecha);           
            3:
                Escribir "Cancelaci�n de pasaje";
                CancelarPasaje(destinos, asientos, pasajerosNombre, pasajerosDNI, pasajerosDestino, pasajerosAsiento, pasajerosPago, pasajerosPagado, pasajerosCodigoQR, ventasPorDestino, TotaldePasajeros, pasajerosFecha);            
            4:
                Escribir "Partidas";
                Partidas(destinos, asientos);
            5:
                Escribir "Volviendo...";
            De Otro Modo:
                Escribir "Opci�n no v�lida.";
        FinSegun
    Hasta Que opc1 = 5;
FinSubProceso


// =======================
// COMPRAR PASAJE
// =======================
SubProceso ComprarPasaje(destinos, asientos, pasajerosNombre, pasajerosDNI, pasajerosDestino, pasajerosAsiento, pasajerosPago, pasajerosPagado, pasajerosCodigoQR, ventasPorDestino, TotaldePasajeros Por Referencia, pasajerosFecha, fechasDisponibles)
    Definir destinoElegido, asientoElegido, filaElegida, colElegida, i, j Como Entero;
    Definir nombre, dni, codigoQR Como Caracter;
    Definir precioBase Como Real;
    Definir asientoDisponible Como Logico;
	
    // Destinos (tu listado original se mantiene)
    Escribir "DESTINOS DISPONIBLES:";
    Para i <- 0 Hasta 5 Hacer
        Escribir destinos[i,0], " - ", destinos[i,1], " -> ", destinos[i,2], " - $", destinos[i,3];
    FinPara
    // [CAMBIO] Lectura validada de destino
    destinoElegido <- LeerNumeroEnRango("Seleccione el n�mero de destino: ", 1, 6, 2) - 1;
    
    // Fecha fija 
    pasajerosFecha[TotaldePasajeros] <- fechasDisponibles[destinoElegido,0];
    precioBase <- ConvertirANumero(destinos[destinoElegido,3]);
    
    Escribir "Fecha de vuelo disponible: ", pasajerosFecha[TotaldePasajeros];
    
    // Mapa del avi�n (10 filas x 4 columnas)
    Escribir "";
    ImprimirMatrizAsientos(asientos, destinoElegido);
    
    // Elegir asiento por fila/columna
    asientoDisponible <- Falso;
    Mientras No asientoDisponible Hacer
        // [CAMBIO] Lecturas validadas
        filaElegida <- LeerNumeroEnRango("Seleccione fila (1-10): ", 1, 10, 2) - 1;
        colElegida  <- LeerNumeroEnRango("Seleccione columna (1-4) [1=A,2=B,3=C,4=D]: ", 1, 4, 2) - 1;
        
        Si filaElegida < 0 O filaElegida > 9 O colElegida < 0 O colElegida > 3 Entonces
            Escribir "Posici�n inv�lida.";
        Sino
            asientoElegido <- filaElegida*4 + colElegida;
            Si asientos[destinoElegido, asientoElegido] = 0 Entonces
                asientoDisponible <- Verdadero;
                asientos[destinoElegido, asientoElegido] <- 1;
            Sino
                Escribir "Asiento ocupado. Elija otro.";
            FinSi
        FinSi
    FinMientras
    
    // Datos del pasajero
    Escribir "-------------------------------------------";
    Escribir "DATOS DEL PASAJERO";
    Escribir "-------------------------------------------";
    // Lecturas validadas de nombre y DNI + control duplicado
    nombre <- LeerNombreValido("Nombre: ");
    dni <- LeerDNIValido;
	
	
    Si DniExiste(pasajerosDNI, TotaldePasajeros, dni) Entonces
        Escribir "Ese DNI ya tiene pasaje. Operaci�n cancelada.";
        asientos[destinoElegido, asientoElegido] <- 0 ; // liberar asiento reservado
    Sino
        // Guardar
        pasajerosNombre[TotaldePasajeros] <- nombre;
        pasajerosDNI[TotaldePasajeros] <- dni;
        pasajerosDestino[TotaldePasajeros] <- destinoElegido;
        pasajerosAsiento[TotaldePasajeros] <- asientoElegido;
        pasajerosPago[TotaldePasajeros] <- precioBase ;
        pasajerosPagado[TotaldePasajeros] <- Verdadero;
        
        // Generar QR
        codigoQR <- "TERMINAL|" + dni + "|" + ConvertirATexto(destinoElegido+1) + "|" + ConvertirATexto(asientoElegido+1);
        pasajerosCodigoQR[TotaldePasajeros] <- codigoQR;
        
        // Mostrar QR
        Escribir "_________________________________________";
        Escribir "                ## ## #####  #####";
        Escribir "                ### #   QR   #####";
        Escribir "                # # #        ## ##";
        Escribir "                # ###        # ###";
        // [CAMBIO] Subcadena base 0
        Escribir "                ### #  ", Subcadena(dni, 0, 4), " # ###";
        Escribir "                # ###    ", ConvertirATexto(asientoElegido+1), "   # # #";
        Escribir "                ## ## ##### ###  #";
        Escribir "_________________________________________";
        Escribir "C�digo QR: ", codigoQR;
        Escribir "_________________________________________";
        Esperar 1 Segundos;
        
        // Confirmaci�n
        Escribir "===========================================";
        Escribir "�RESERVA CONFIRMADA Y PAGADA!";
        Esperar 2 Segundos;
        Escribir "Destino: ", destinos[destinoElegido,1], " -> ", destinos[destinoElegido,2];
        Escribir "Fecha: ", pasajerosFecha[TotaldePasajeros];
        Escribir "Asiento (n�mero interno): ", (asientoElegido + 1);
        Escribir "Precio final: $", precioBase;
        Escribir "===========================================";
        Esperar 2 Segundos;
        
        // Contadores
        TotaldePasajeros <- TotaldePasajeros + 1;
        ventasPorDestino[destinoElegido] <- ventasPorDestino[destinoElegido] + 1;
    FinSi
FinSubProceso



// =======================
// CONTROL TICKET
// =======================
SubProceso ControlTicket(destinos, asientos, pasajerosNombre, pasajerosDNI, pasajerosDestino, pasajerosAsiento, pasajerosPago, pasajerosPagado, pasajerosCodigoQR, ventasPorDestino, TotaldePasajeros Por Referencia, pasajerosFecha)    
    Definir i, encontrado, destinoIdx Como Entero;
    Definir dniBuscado Como Caracter;
    
    Si TotaldePasajeros = 0 Entonces
        Escribir "No hay pasajeros registrados.";
        Esperar Tecla;
    Sino
        Escribir "CONTROL DE TICKET";
        Escribir "Ingrese DNI:";
        // [CAMBIO] Lectura validada de DNI
        dniBuscado <- LeerDNIValido;
        
        encontrado <- -1;
        Para i <- 0 Hasta TotaldePasajeros - 1 Hacer
            Si pasajerosDNI[i] = dniBuscado Entonces
                encontrado <- i;
            FinSi
        FinPara
        
        Si encontrado = -1 Entonces
            Escribir "No se encontr� el ticket.";
        Sino
            Limpiar Pantalla;
            destinoIdx <- pasajerosDestino[encontrado];
            Escribir "===========================================";
            Escribir "TICKET DE EMBARQUE";
            Escribir "Nombre: ", pasajerosNombre[encontrado];
            Escribir "DNI: ", pasajerosDNI[encontrado];
            Escribir "Destino: ", destinos[destinoIdx,1], " -> ", destinos[destinoIdx,2];
            Escribir "Fecha: ", pasajerosFecha[encontrado];
            Escribir "Asiento (n�mero interno): ", pasajerosAsiento[encontrado] + 1;
            Escribir "Precio: $", pasajerosPago[encontrado];
            Si pasajerosPagado[encontrado] Entonces
                Escribir "Estado: PAGADO";
                Escribir "C�digo QR: ", pasajerosCodigoQR[encontrado];
            Sino
                Escribir "Estado: PENDIENTE DE PAGO";
            FinSi
            Escribir "===========================================";
            Esperar 2 Segundos;
        FinSi
    FinSi
FinSubProceso


// =======================
// CANCELAR PASAJE
// =======================
SubProceso CancelarPasaje(destinos, asientos, pasajerosNombre, pasajerosDNI, pasajerosDestino, pasajerosAsiento, pasajerosPago, pasajerosPagado, pasajerosCodigoQR, ventasPorDestino, TotaldePasajeros Por Referencia, pasajerosFecha)
    Definir dniBuscado, confirmacion Como Caracter;
    Definir i, encontrado, destinoIdx, asientoIdx Como Entero;
    
    Escribir "Ingrese DNI para cancelar:";
    // [CAMBIO] Lectura validada de DNI
    dniBuscado <- LeerDNIValido();
    
    encontrado <- -1;
    Para i <- 0 Hasta TotaldePasajeros - 1 Hacer
        Si pasajerosDNI[i] = dniBuscado Entonces
            encontrado <- i;
        FinSi
    FinPara
    
    Si encontrado = -1 Entonces
        Escribir "No se encontr� el pasaje.";
    Sino
        destinoIdx <- pasajerosDestino[encontrado];
        asientoIdx <- pasajerosAsiento[encontrado];
        Limpiar Pantalla;
        Escribir "-------------------------------------------";
        Escribir "Pasajero: ", pasajerosNombre[encontrado], " | DNI: ", pasajerosDNI[encontrado];
        Escribir "Destino: ", destinos[destinoIdx,1], " -> ", destinos[destinoIdx,2];
        Escribir "Asiento (n�mero interno): ", asientoIdx + 1;
        Escribir "-------------------------------------------";
        // [CAMBIO] Confirmaci�n segura y acciones de cancelaci�n
        confirmacion <- LeerConfirmacionSN("�Seguro cancelar?");
        Si confirmacion = "S" Entonces
            Escribir "ATENCI�N: La empresa no reconoce reembolso.";
            Escribir "Motivo: cancelaci�n del usuario.";
            asientos[destinoIdx, asientoIdx] <- 0;
            pasajerosNombre[encontrado] <- "CANCELADO";
            pasajerosPagado[encontrado] <- Falso;
            Si ventasPorDestino[destinoIdx] > 0 Entonces
                ventasPorDestino[destinoIdx] <- ventasPorDestino[destinoIdx] - 1;
            FinSi
            Escribir "Cancelado con �xito.";
        SiNo
            Escribir "Cancelaci�n abortada.";
        FinSi
        Esperar 2 Segundos;
    FinSi
FinSubProceso


// =======================
// PARTIDAS
// =======================
SubProceso Partidas(destinos, asientos)
    Definir i, j, libres Como Entero;
    Limpiar Pantalla;
    Escribir "===========================================";
    Escribir "           LISTA DE PARTIDAS";
    Escribir "===========================================";
    Para i <- 0 Hasta 5 Hacer
        libres <- 0;
        Para j <- 0 Hasta 39 Hacer
            Si asientos[i, j] = 0 Entonces
                libres <- libres + 1;
            FinSi
        FinPara
        Escribir destinos[i,1], " -> ", destinos[i,2], " | Asientos libres: ", libres;
    FinPara
    Escribir "===========================================";
    Esperar 2 Segundos;
FinSubProceso