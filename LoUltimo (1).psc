Proceso TerminalAutogestion
    // ==============
    // VARIABLES 
    // ==============

    Definir asientos, pasajerosDestino, pasajerosAsiento, TotaldePasajeros, ventasPorDestino, opc Como Entero;
    Definir destinos, pasajerosNombre,pasajerosDNI, pasajerosCodigoQR, pasajerosFecha, fechasDisponibles Como Caracter;
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

    // Inicializar
	InicializarSistema(destinos, asientos, ventasPorDestino, TotaldePasajeros, pasajerosDNI, pasajerosCodigoQR, fechasDisponibles, pasajerosPago, pasajerosDestino);	
    
	// MENU PRINCIPAL DE USUARIOS
    Repetir
        Escribir "===========================================";
        Escribir "    TERMINAL DE AUTOGESTIÓN DE PASAJES";
        Escribir "===========================================";
        Escribir "1. Cliente";
        Escribir "2. Administrador";
        Escribir "3. Salir";
        Escribir "-------------------------------------------";
        Escribir Sin Saltar "Seleccione su tipo de usuario: ";
        Leer opc;
        
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
                Escribir "¡Hasta pronto!";
            De Otro Modo:
                Escribir "Opción no válida. Intente nuevamente.";
        FinSegun
    Hasta Que opc = 3;
FinProceso

// =======================
// SUBPROCESOS
// =======================


// =======================
// INICIALIZACIÓN
// =======================
SubProceso InicializarSistema(destinos, asientos, ventasPorDestino, TotaldePasajeros Por Referencia, pasajerosDNI, pasajerosCodigoQR, fechasDisponibles, pasajerosPago, pasajerosDestino)
    Definir i, j Como Entero;
    
    // Destinos
    destinos[0,0] = "1"; destinos[0,1] = "BUENOS AIRES"; destinos[0,2] = "JUJUY"; destinos[0,3] = "15000";
    destinos[1,0] = "2"; destinos[1,1] = "BUENOS AIRES"; destinos[1,2] = "SANTA CRUZ"; destinos[1,3] = "18000";
    destinos[2,0] = "3"; destinos[2,1] = "BUENOS AIRES"; destinos[2,2] = "MISIONES"; destinos[2,3] = "12000";
    destinos[3,0] = "4"; destinos[3,1] = "JUJUY"; destinos[3,2] = "BUENOS AIRES"; destinos[3,3] = "15000";
    destinos[4,0] = "5"; destinos[4,1] = "SANTA CRUZ"; destinos[4,2] = "BUENOS AIRES"; destinos[4,3] = "18000";
    destinos[5,0] = "6"; destinos[5,1] = "MISIONES"; destinos[5,2] = "BUENOS AIRES"; destinos[5,3] = "12000";
    
    // Fechas disponibles 
    Para i <- 0 Hasta 5 Hacer
        fechasDisponibles[i,0] <- convertiratexto(aleatorio(1,30)) + "/11/2025"; 
    FinPara
    
    // Asientos (todos libres)
    Para i <- 0 Hasta 5 Hacer
        Para j <- 0 Hasta 39 Hacer
            asientos[i,j] <- 0;
        FinPara
    FinPara
    
    // Ventas y pasajeros
    Para i <- 0 Hasta 5 Hacer
        ventasPorDestino[i] <- 0;
    FinPara
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

SubProceso accesoAdmin <- AutenticarAdmin
    Definir accesoAdmin Como Logico;
    Definir usuario, clave Como Cadena;
    
    accesoAdmin <- Falso;
    Escribir "-------------------------------------------";
    Escribir "INGRESO ADMINISTRADOR";
    Escribir Sin Saltar "Usuario: ";
    Leer usuario;
    Escribir Sin Saltar "Contraseña: ";
    Leer clave;
    
    Si usuario = "admin" Y clave = "1234" Entonces
        accesoAdmin <- Verdadero;
        Escribir "¡Acceso concedido!";
    Sino
        Escribir "Credenciales incorrectas.";
    FinSi
FinSubProceso

// =======================
// MENÚ ADMIN
// =======================

SubProceso MenuAdministrador(destinos, asientos, pasajerosNombre, pasajerosDNI, pasajerosDestino, pasajerosAsiento, pasajerosPago, pasajerosPagado, pasajerosCodigoQR, ventasPorDestino, TotaldePasajeros Por Referencia, pasajerosFecha)
    Definir opc Como Entero;
    
    Repetir
        Escribir "===========================================";
        Escribir "          MENÚ ADMINISTRADOR";
        Escribir "===========================================";
        Escribir "1. Ver balance de transporte";
        Escribir "2. Ver estado de los asientos";
        Escribir "3. Ver lista de pasajeros";
        Escribir "4. Volver al menú principal";
        Escribir "-------------------------------------------";
        Escribir Sin Saltar "Seleccione una opción: ";
        Leer opc;
        
        Segun opc Hacer
            1: 
				BalanceTransporte(destinos, ventasPorDestino, pasajerosDestino, pasajerosPago, TotaldePasajeros);
            2: 
				EstadoAsientos(destinos, asientos);
            3: 
                Escribir "Listado de pasajeros";
                ListaPasajeros(pasajerosNombre, pasajerosDNI, pasajerosDestino, pasajerosAsiento, pasajerosPago, pasajerosPagado, pasajerosCodigoQR, destinos, TotaldePasajeros, pasajerosFecha);
            4: Escribir "Volviendo...";
            De Otro Modo: Escribir "Opción no válida.";
        FinSegun
    Hasta Que opc = 4;
FinSubProceso

// imprime matriz de asientos
SubProceso ImprimirMatrizAsientos(asientos, destinoElegido)
    Definir i, j, asientoActual Como Entero;
    
    Escribir "MAPA DEL AVIÓN (O=libre / X=ocupado)";
	Escribir "         ______";
	Escribir "       /        \";
	Escribir "     /           \";
    Escribir "    /A  B     C  D\";
    
    Para i <- 0 Hasta 9 Hacer
        si i = 9 Entonces
            Escribir Sin Saltar "F", (i+1), " ";
        SiNo
            Escribir Sin Saltar "F", (i+1), "  ";
        FinSi
        
        // Lado izquierdo
        Para j <- 0 Hasta 1 Hacer
            asientoActual <- i*4 + j;
            Si asientos[destinoElegido, asientoActual] = 0 Entonces
                Escribir Sin Saltar "[O]";
            Sino
                Escribir Sin Saltar "[X]";
            FinSi
        FinPara
        
        Escribir Sin Saltar " | "; // Pasillo
        
        // Lado derecho
        Para j <- 2 Hasta 3 Hacer
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
        // Menú de selección de destino
        Escribir "===========================================";
        Escribir "        ESTADO DE ASIENTOS - MENÚ";
        Escribir "===========================================";
        Escribir "Seleccione el destino a visualizar:";
        Para i <- 0 Hasta 5 Hacer
            Escribir (i+1), ". ", destinos[i,1], " -> ", destinos[i,2];
        FinPara
        Escribir "7. Volver al menú anterior";
        Escribir "-------------------------------------------";
        Escribir Sin Saltar "Seleccione una opción: ";
        Leer opc;
        
        Si opc >= 1 Y opc <= 6 Entonces
            destinoElegido <- opc - 1;
            
            // Contar asientos ocupados y vacíos
            ocupados <- 0;
            vacios <- 0;
            
            Para i <- 0 Hasta 39 Hacer
                Si asientos[destinoElegido, i] = 1 Entonces
                    ocupados <- ocupados + 1;
                Sino
                    vacios <- vacios + 1;
                FinSi
            FinPara
            
            // Calcular porcentaje de ocupación
            porcentajeOcupacion <- (ocupados / 40) * 100;
            
            // Mostrar matriz de asientos
            Escribir "";
			Limpiar Pantalla;
            Escribir "===========================================";
            Escribir "    ESTADO DE ASIENTOS - ", destinos[destinoElegido,1], " -> ", destinos[destinoElegido,2];
            Escribir "===========================================";
			ImprimirMatrizAsientos(asientos, destinoElegido);
            
            // Mostrar estadísticas
            Escribir "===========================================";
            Escribir "ESTADÍSTICAS DE OCUPACIÓN:";
            Escribir "-------------------------------------------";
			Escribir "Total de asientos:  ", 40;
            Escribir "Asientos ocupados: ", ocupados;
            Escribir "Asientos vacíos:   ", vacios;
            Escribir "Ocupación: ", Redon(porcentajeOcupacion), "%";
            
            
			Escribir "===========================================";
			Escribir "Presione cualquier tecla para continuar...";
			Esperar Tecla;
			
		Sino 
			Si opc = 7 Entonces
				Esperar 1 Segundos;
				Escribir "Volviendo al menú anterior...";
				Limpiar Pantalla;
			Sino
				Escribir "Opción no válida. Intente nuevamente.";
			FinSi
		FinSi
	Hasta Que opc = 7;
FinSubProceso


SubProceso BalanceTransporte(destinos, ventasPorDestino, pasajerosDestino, pasajerosPago, TotaldePasajeros)
    Definir i, j, destinoIdx, totalVendidos, destinoMasVendido, maxVentas Como Entero;
    Definir totalRecaudado, promedioVenta, recaudacionPorDestino Como Real;
    Definir porcentajeVentas Como Real;
    
    totalVendidos <- 0;
    totalRecaudado <- 0;
    maxVentas <- 0;
    destinoMasVendido <- 0;
	i=0;
	j=0;
    
	si TotaldePasajeros>0 Entonces
		
		// Calcular totales
		Para i <- 0 Hasta 5 Hacer
			totalVendidos <- totalVendidos + ventasPorDestino[i];
			Si ventasPorDestino[i] > maxVentas Entonces
				maxVentas <- ventasPorDestino[i];
				destinoMasVendido <- i;
			FinSi
		FinPara
		
		// Calcular recaudación total
		Para i <- 0 Hasta TotaldePasajeros-1 Hacer
			totalRecaudado <- totalRecaudado + pasajerosPago[i];
		FinPara
		
		// Calcular promedio
		Si totalVendidos > 0 Entonces
			promedioVenta <- totalRecaudado / totalVendidos;
			promedioVenta <- redon(promedioVenta);
		Sino
			promedioVenta <- 0;
		FinSi
		
		// Mostrar balance general
		Limpiar Pantalla;
		Escribir "===========================================";
		Escribir "          BALANCE DE TRANSPORTE";
		Escribir "===========================================";
		Escribir "-------------------------------------------";
		Escribir "ESTADÍSTICAS GENERALES:";
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
			
			// Calcular recaudación por destino
			recaudacionPorDestino <- 0;
			Para j <- 0 Hasta TotaldePasajeros-1 Hacer
				Si pasajerosDestino[j] = i Entonces
					recaudacionPorDestino <- recaudacionPorDestino + pasajerosPago[j];
				FinSi
			FinPara
			
			Escribir destinos[i,1], " -> ", destinos[i,2], ":";
			Escribir "Pasajes: ", ventasPorDestino[i], " (", Redon(porcentajeVentas), "%)";
			Escribir "Recaudación: $", recaudacionPorDestino;
			Escribir "";
		FinPara
		
		// Mostrar destino más vendido
		Escribir "-------------------------------------------";
		Escribir "DESTINO MÁS POPULAR:";
		Escribir "-------------------------------------------";
		Si maxVentas > 0 Entonces
			Escribir destinos[destinoMasVendido,1], " -> ", destinos[destinoMasVendido,2];
			Escribir "Con ", maxVentas, " pasajes vendidos";
			
			// Mostrar porcentaje del destino más vendido
			Si totalVendidos > 0 Entonces
				porcentajeVentas <- (maxVentas / totalVendidos) * 100;
				Escribir "Representa el ", Redon(porcentajeVentas), "% de las ventas totales";
			FinSi
		Sino
			Escribir "No hay ventas registradas";
		FinSi
		
		// Análisis de ocupación
		Escribir "";
		Escribir "-------------------------------------------";
		Escribir "ANÁLISIS DE OCUPACIÓN:";
		Escribir "-------------------------------------------";
		Si totalVendidos > 0 Entonces
			Escribir "Tasa de ocupación general: ", Redon((totalVendidos / (6 * 40)) * 100), "%";
			
			// Encontrar destino con mejor y peor ocupación
			Definir mejorOcupacion, peorOcupacion, idxMejor, idxPeor Como real;
			mejorOcupacion <- 0;
			peorOcupacion <- 100;
			idxMejor <- 0;
			idxPeor <- 0;
			
			Para i <- 0 Hasta 5 Hacer
				porcentajeVentas <- (ventasPorDestino[i] / 40) * 100;
				
				Si porcentajeVentas > mejorOcupacion Entonces
					mejorOcupacion <- porcentajeVentas;
					idxMejor <- i;
				FinSi
				
				Si porcentajeVentas < peorOcupacion Entonces
					peorOcupacion <- porcentajeVentas;
					idxPeor <- i;
				FinSi
			FinPara
			
			Escribir "Mejor ocupación: ", destinos[idxMejor,1], " -> ", destinos[idxMejor,2];
			Escribir "  (", Redon(mejorOcupacion), "% de asientos vendidos)";
			Escribir "Menor ocupación: ", destinos[idxPeor,1], " -> ", destinos[idxPeor,2];
			Escribir "  (", Redon(peorOcupacion), "% de asientos vendidos)";
		FinSi
		
		Escribir "===========================================";
		Escribir "Presione cualquier tecla para continuar...";
		Esperar Tecla;
		Limpiar Pantalla;
	sino
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
            Escribir "Pasajero Nº ", (i+1);
            Escribir "Nombre: ", pasajerosNombre[i];
            Escribir "DNI: ", pasajerosDNI[i];
            Escribir "Destino: ", destinos[destinoIdx,1], " -> ", destinos[destinoIdx,2];
            Escribir "Fecha: ", pasajerosFecha[i];
            Escribir "Asiento (número interno): ", (pasajerosAsiento[i] + 1);
            Escribir "Precio: $", pasajerosPago[i];
            Si pasajerosPagado[i] Entonces
                Escribir "Estado: PAGADO";
                Escribir "Código QR: ", pasajerosCodigoQR[i];
            Sino
                Escribir "Estado: PENDIENTE DE PAGO";
            FinSi
        FinPara
    FinSi
	
    Escribir "===========================================";
FinSubProceso


// =======================
// MENÚ CLIENTE
// =======================
SubProceso MenuCliente(destinos, asientos, pasajerosNombre, pasajerosDNI, pasajerosDestino, pasajerosAsiento, pasajerosPago, pasajerosPagado, pasajerosCodigoQR, ventasPorDestino, TotaldePasajeros Por Referencia, fechasDisponibles, pasajerosFecha)    
    Repetir
        Escribir "===========================================";
        Escribir "            MENÚ CLIENTE";
        Escribir "===========================================";
        Escribir "1. Comprar pasaje";
        Escribir "2. Control de ticket";
        Escribir "3. Cancelaciones";
        Escribir "4. Partidas";
        Escribir "5. Volver al menú principal";
        Escribir "-------------------------------------------";
        Escribir Sin Saltar "Seleccione una opción: ";
        Leer opc1;
        
        Segun opc1 Hacer
            1:
                Escribir "Compra de pasaje";
				ComprarPasaje(destinos, asientos, pasajerosNombre, pasajerosDNI, pasajerosDestino, pasajerosAsiento, pasajerosPago, pasajerosPagado, pasajerosCodigoQR, ventasPorDestino, TotaldePasajeros, pasajerosFecha, fechasDisponibles);                
				Escribir "Control de ticket";
			2:	
				Escribir "Control de ticket";
				ControlTicket(destinos, asientos, pasajerosNombre, pasajerosDNI, pasajerosDestino, pasajerosAsiento, pasajerosPago, pasajerosPagado, pasajerosCodigoQR, ventasPorDestino, TotaldePasajeros, pasajerosFecha);           
			3:
				Escribir "Cancelación de pasaje";
				CancelarPasaje(destinos, asientos, pasajerosNombre, pasajerosDNI, pasajerosDestino, pasajerosAsiento, pasajerosPago, pasajerosPagado, pasajerosCodigoQR, ventasPorDestino, TotaldePasajeros, pasajerosFecha);            
			4:
				Escribir "Partidas";
				Partidas(destinos, asientos);
			5:
				Escribir "Volviendo...";
			De Otro Modo:
				Escribir "Opción no válida.";
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
    
    // Destinos
	Repetir
		Escribir "DESTINOS DISPONIBLES:";
		Para i <- 0 Hasta 5 Hacer
			Escribir destinos[i,0], " - ", destinos[i,1], " -> ", destinos[i,2], " - $", destinos[i,3];
		FinPara
		
		Escribir "Seleccione el número de destino:";
		Leer destinoElegido;
		destinoElegido <- destinoElegido - 1;
		Si destinoElegido < 0 O destinoElegido > 5 Entonces
			Escribir "Destino no válido.";
		FinSi
	Hasta Que destinoElegido >= 0 Y destinoElegido <= 5
    
    
    // Fecha fija (solo hay una disponible)
    pasajerosFecha[TotaldePasajeros] <- fechasDisponibles[destinoElegido,0];
    precioBase <- ConvertirANumero(destinos[destinoElegido,3]);
    
    Escribir "Fecha de vuelo disponible: ", pasajerosFecha[TotaldePasajeros];
    
    // Mapa del avión (10 filas x 4 columnas)
    Escribir "";
    ImprimirMatrizAsientos(asientos, destinoElegido);
    
    // Elegir asiento por fila/columna
    asientoDisponible <- Falso;
    Mientras No asientoDisponible Hacer
        Escribir "Seleccione fila (1-10): ";
        Leer filaElegida;
        Escribir "Seleccione columna (1-4) [1=A,2=B,3=C,4=D]: ";
        Leer colElegida;
        
        filaElegida <- filaElegida - 1;
        colElegida <- colElegida - 1;
        
        Si filaElegida < 0 O filaElegida > 9 O colElegida < 0 O colElegida > 3 Entonces
            Escribir "Posición inválida.";
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
    Escribir "Nombre: "; Leer nombre;
    Escribir "DNI: "; Leer dni;
    
    // Guardar
    pasajerosNombre[TotaldePasajeros] <- nombre;
    pasajerosDNI[TotaldePasajeros] <- dni;
    pasajerosDestino[TotaldePasajeros] <- destinoElegido;
    pasajerosAsiento[TotaldePasajeros] <- asientoElegido;
    pasajerosPago[TotaldePasajeros] <- precioBase; 
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
    Escribir "                ### #  ", Subcadena(dni,1,5), " # ###";
    Escribir "                # ###    ", ConvertirATexto(asientoElegido+1), "   # # #";
    Escribir "                ## ## ##### ###  #";
    Escribir "_________________________________________";
    Escribir "Código QR: ", codigoQR;
    Escribir "_________________________________________";
    esperar 1 Segundos;
    // Confirmación
    Escribir "===========================================";
    Escribir "¡RESERVA CONFIRMADA Y PAGADA!";
	esperar 2 Segundos;
    Escribir "Destino: ", destinos[destinoElegido,1], " -> ", destinos[destinoElegido,2];
    Escribir "Fecha: ", pasajerosFecha[TotaldePasajeros];
    Escribir "Asiento (número interno): ", (asientoElegido + 1);
    Escribir "Precio final: $", precioBase;
    Escribir "===========================================";
    esperar 2 Segundos;
    // Contadores
    TotaldePasajeros <- TotaldePasajeros + 1;
    ventasPorDestino[destinoElegido] <- ventasPorDestino[destinoElegido] + 1;
FinSubProceso

// =======================
// CONTROL TICKET
// =======================
SubProceso ControlTicket(destinos, asientos, pasajerosNombre, pasajerosDNI, pasajerosDestino, pasajerosAsiento, pasajerosPago, pasajerosPagado, pasajerosCodigoQR, ventasPorDestino, TotaldePasajeros Por Referencia, pasajerosFecha)    
	Definir i, encontrado, destinoIdx Como Entero;
    Definir dniBuscado Como Caracter;
	
    Si TotaldePasajeros = 0 Entonces
        Escribir "No hay pasajeros registrados.";
        Leer Retornar;
    FinSi
	
    Escribir "CONTROL DE TICKET";
    Escribir "Ingrese DNI:";
    Leer dniBuscado;
	
    encontrado <- -1;
    Para i <- 0 Hasta TotaldePasajeros - 1 Hacer
        Si pasajerosDNI[i] = dniBuscado Entonces
            encontrado <- i;
        FinSi
    FinPara
	
    Si encontrado = -1 Entonces
        Escribir "No se encontró el ticket.";
    Sino
		Limpiar Pantalla;
        destinoIdx <- pasajerosDestino[encontrado];
        Escribir "===========================================";
        Escribir "TICKET DE EMBARQUE";
        Escribir "Nombre: ", pasajerosNombre[encontrado];
        Escribir "DNI: ", pasajerosDNI[encontrado];
        Escribir "Destino: ", destinos[destinoIdx,1], " -> ", destinos[destinoIdx,2];
        Escribir "Fecha: ", pasajerosFecha[encontrado];
        Escribir "Asiento (número interno): ", pasajerosAsiento[encontrado] + 1;
        Escribir "Precio: $", pasajerosPago[encontrado];
        Si pasajerosPagado[encontrado] Entonces
            Escribir "Estado: PAGADO";
            Escribir "Código QR: ", pasajerosCodigoQR[encontrado];
        Sino
            Escribir "Estado: PENDIENTE DE PAGO";
        FinSi
        Escribir "===========================================";
		esperar 2 Segundos;
    FinSi
FinSubProceso

// =======================
// CANCELAR PASAJE
// =======================
SubProceso CancelarPasaje(destinos, asientos, pasajerosNombre, pasajerosDNI, pasajerosDestino, pasajerosAsiento, pasajerosPago, pasajerosPagado, pasajerosCodigoQR, ventasPorDestino, TotaldePasajeros Por Referencia, pasajerosFecha)
	
    Definir dniBuscado, confirmacion Como Caracter;
    Definir i, encontrado, destinoIdx, asientoIdx Como Entero;
	
    Escribir "Ingrese DNI para cancelar:";
    Leer dniBuscado;
	
    encontrado <- -1;
    Para i <- 0 Hasta TotaldePasajeros - 1 Hacer
        Si pasajerosDNI[i] = dniBuscado Entonces
            encontrado <- i;
        FinSi
    FinPara
	
    Si encontrado = -1 Entonces
        Escribir "No se encontró el pasaje.";
    Sino
        destinoIdx <- pasajerosDestino[encontrado];
        asientoIdx <- pasajerosAsiento[encontrado];
		Limpiar Pantalla;
        Escribir "-------------------------------------------";
        Escribir "Pasajero: ", pasajerosNombre[encontrado], " | DNI: ", pasajerosDNI[encontrado];
        Escribir "Destino: ", destinos[destinoIdx,1], " -> ", destinos[destinoIdx,2];
        Escribir "Asiento (número interno): ", asientoIdx + 1;
        Escribir "-------------------------------------------";
        Escribir "¿Seguro cancelar? (S/N):";
        Leer confirmacion;
		
        Si confirmacion = "S" O confirmacion = "s" Entonces
            Escribir "ATENCIÓN: La empresa no reconoce reembolso.";
            Escribir "Motivo: cancelación del usuario.";
            asientos[destinoIdx, asientoIdx] <- 0;
            pasajerosNombre[encontrado] <- "CANCELADO";
            pasajerosPagado[encontrado] <- Falso;
            ventasPorDestino[destinoIdx] <- ventasPorDestino[destinoIdx] - 1;
            Escribir "Cancelado con éxito.";
        Sino
            Escribir "Cancelación abortada.";
        FinSi
		esperar 2 Segundos;
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
