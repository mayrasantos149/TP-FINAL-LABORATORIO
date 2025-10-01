Proceso TerminalAutogestion
    // =======================
    // VARIABLES GLOBALES
    // =======================
    Definir destinos Como Caracter;
    Dimension destinos[6,4];
    
    Definir asientos Como Entero;
    Dimension asientos[6,40]; // 10 filas x 4 columnas = 40 asientos por destino
    
    Definir pasajerosNombre Como Caracter;
    Dimension pasajerosNombre[100];
    Definir pasajerosDNI Como Caracter;
    Dimension pasajerosDNI[100];
    Definir pasajerosDestino Como Entero;
    Dimension pasajerosDestino[100];
    Definir pasajerosAsiento Como Entero;
    Dimension pasajerosAsiento[100];
    Definir pasajerosPago Como Real;
    Dimension pasajerosPago[100];
    Definir pasajerosPagado Como Logico;
    Dimension pasajerosPagado[100];
    Definir pasajerosCodigoQR Como Caracter;
    Dimension pasajerosCodigoQR[100];
    Definir pasajerosFecha Como Caracter;
    Dimension pasajerosFecha[100];
    Definir TotaldePasajeros Como Entero;
    
    // Fechas y descuentos
    Definir fechasDisponibles Como Caracter;
    Dimension fechasDisponibles[6,10];
    Definir descuentosFecha Como Entero;
    Dimension descuentosFecha[6,10];
    
    // Descuentos por destino
    Definir descuentos Como Real;
    Dimension descuentos[6];
    
    Definir ventasPorDestino Como Entero;
    Dimension ventasPorDestino[6];
    Definir totalVentas Como Real;
    
    Definir opc Como Entero;
    Definir auth Como Logico;
    
    // Inicializar
	InicializarSistema(destinos, asientos, descuentos, ventasPorDestino, TotaldePasajeros, pasajerosDNI, pasajerosCodigoQR, fechasDisponibles, descuentosFecha);

    
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
                MenuCliente(destinos, descuentos, asientos, pasajerosNombre, pasajerosDNI, pasajerosDestino, pasajerosAsiento, pasajerosPago, pasajerosPagado, pasajerosCodigoQR, ventasPorDestino, TotaldePasajeros, fechasDisponibles, descuentosFecha, pasajerosFecha);
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
            1: Escribir "Balance de transporte (próximamente)";
            2: Escribir "Estado de los asientos (próximamente)";
            3: 
                Escribir "Listado de pasajeros";
                ListaPasajeros(pasajerosNombre, pasajerosDNI, pasajerosDestino, pasajerosAsiento, pasajerosPago, pasajerosPagado, pasajerosCodigoQR, destinos, TotaldePasajeros, pasajerosFecha);
            4: Escribir "Volviendo...";
            De Otro Modo: Escribir "Opción no válida.";
        FinSegun
    Hasta Que opc = 4;
FinSubProceso

// =======================
// MENÚ CLIENTE
// =======================
SubProceso MenuCliente(destinos, descuentos, asientos, pasajerosNombre, pasajerosDNI, pasajerosDestino, pasajerosAsiento, pasajerosPago, pasajerosPagado, pasajerosCodigoQR, ventasPorDestino, TotaldePasajeros Por Referencia, fechasDisponibles, descuentosFecha, pasajerosFecha)
    Definir opc Como Entero;
    
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
        Leer opc;
        
        Segun opc Hacer
            1:
                Escribir "Compra de pasaje";
                ComprarPasaje(destinos, descuentos, asientos, pasajerosNombre, pasajerosDNI, pasajerosDestino, pasajerosAsiento, pasajerosPago, pasajerosPagado, pasajerosCodigoQR, ventasPorDestino, TotaldePasajeros, pasajerosFecha, fechasDisponibles, descuentosFecha);
            2:
                Escribir "Control de ticket";
                ControlTicket(destinos, descuentos, asientos, pasajerosNombre, pasajerosDNI, pasajerosDestino, pasajerosAsiento, pasajerosPago, pasajerosPagado, pasajerosCodigoQR, ventasPorDestino, TotaldePasajeros, pasajerosFecha);
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
    Hasta Que opc = 5;
FinSubProceso

// =======================
// INICIALIZACIÓN
// =======================
SubProceso InicializarSistema(destinos, asientos, descuentos, ventasPorDestino, TotaldePasajeros Por Referencia, pasajerosDNI, pasajerosCodigoQR, fechasDisponibles, descuentosFecha)
    Definir i, j Como Entero;
    
    // Inicializar descuentos (0% inicialmente)
    Para i <- 0 Hasta 5 Hacer
        descuentos[i] <- 0;
    FinPara
    
    // Destinos
    destinos[0,0] = "1"; destinos[0,1] = "BUENOS AIRES"; destinos[0,2] = "JUJUY"; destinos[0,3] = "15000";
    destinos[1,0] = "2"; destinos[1,1] = "BUENOS AIRES"; destinos[1,2] = "SANTA CRUZ"; destinos[1,3] = "18000";
    destinos[2,0] = "3"; destinos[2,1] = "BUENOS AIRES"; destinos[2,2] = "MISIONES"; destinos[2,3] = "12000";
    destinos[3,0] = "4"; destinos[3,1] = "JUJUY"; destinos[3,2] = "BUENOS AIRES"; destinos[3,3] = "15000";
    destinos[4,0] = "5"; destinos[4,1] = "SANTA CRUZ"; destinos[4,2] = "BUENOS AIRES"; destinos[4,3] = "18000";
    destinos[5,0] = "6"; destinos[5,1] = "MISIONES"; destinos[5,2] = "BUENOS AIRES"; destinos[5,3] = "12000";
    
    // Fechas y descuentos por destino (10 fechas cada uno)
    Para i <- 0 Hasta 5 Hacer
        Para j <- 0 Hasta 9 Hacer
            fechasDisponibles[i,j] <- ConvertirATexto(j+1) + "/11/2025";
            descuentosFecha[i,j] <- 0; // sin descuento por defecto
        FinPara
    FinPara
    // 2 fechas con descuento por destino (ejemplos)
    descuentosFecha[0,2] <- 20; descuentosFecha[0,7] <- 15;
    descuentosFecha[1,1] <- 10; descuentosFecha[1,5] <- 25;
    descuentosFecha[2,0] <- 30; descuentosFecha[2,9] <- 15;
    descuentosFecha[3,3] <- 10; descuentosFecha[3,6] <- 20;
    descuentosFecha[4,4] <- 15; descuentosFecha[4,8] <- 10;
    descuentosFecha[5,2] <- 25; descuentosFecha[5,5] <- 15;
    
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
    FinPara
    
    TotaldePasajeros <- 0;
    totalVentas <- 0;
FinSubProceso


// =======================
// COMPRAR PASAJE
// =======================
SubProceso ComprarPasaje(destinos, descuentos, asientos, pasajerosNombre, pasajerosDNI, pasajerosDestino, pasajerosAsiento, pasajerosPago, pasajerosPagado, pasajerosCodigoQR, ventasPorDestino, TotaldePasajeros Por Referencia, pasajerosFecha, fechasDisponibles, descuentosFecha)

    Definir destinoElegido, opcionFecha, descuentoElegido, asientoElegido, filaElegida, colElegida, i, j Como Entero;
    Definir nombre, dni, codigoQR, espera Como Caracter;
    Definir precioBase, precioConDescuento Como Real;
    Definir asientoDisponible Como Logico;
	
    // Destinos
    Escribir "DESTINOS DISPONIBLES:";
    Para i <- 0 Hasta 5 Hacer
        Escribir destinos[i,0], " - ", destinos[i,1], " -> ", destinos[i,2], " - $", destinos[i,3];
    FinPara
	
    Escribir "Seleccione el número de destino:";
    Leer destinoElegido;
    destinoElegido <- destinoElegido - 1;
    Si destinoElegido < 0 O destinoElegido > 5 Entonces
        Escribir "Destino no válido.";
        Leer Retornar;
    FinSi
	
    // Fechas
    Escribir "FECHAS DISPONIBLES:";
    Para i <- 0 Hasta 9 Hacer
        Escribir (i+1), ". ", fechasDisponibles[destinoElegido, i];
        Si descuentosFecha[destinoElegido, i] > 0 Entonces
            Escribir "   ---> Descuento del ", descuentosFecha[destinoElegido, i], "%";
        FinSi
    FinPara
	
    Escribir "Seleccione la fecha de vuelo:";
    Leer opcionFecha;
    opcionFecha <- opcionFecha - 1;
    Si opcionFecha < 0 O opcionFecha > 9 Entonces
        Escribir "Fecha no válida.";
        Leer Retornar;
    FinSi
	
    pasajerosFecha[TotaldePasajeros] <- fechasDisponibles[destinoElegido, opcionFecha];
    precioBase <- ConvertirANumero(destinos[destinoElegido,3]);
    descuentoElegido <- descuentosFecha[destinoElegido, opcionFecha];
    precioConDescuento <- precioBase * (1 - descuentoElegido / 100);
	
    // Mapa del avión (10 filas x 4 columnas)
    Escribir "";
    Escribir "MAPA DEL AVIÓN (O=libre / X=ocupado)";
    Escribir "    A   B   C   D";
    Para i <- 0 Hasta 9 Hacer
        Escribir Sin Saltar "F", (i+1), " ";
        Para j <- 0 Hasta 3 Hacer
            asientoElegido <- i*4 + j;
            Si asientos[destinoElegido, asientoElegido] = 0 Entonces
                Escribir Sin Saltar "[O] ";
            Sino
                Escribir Sin Saltar "[X] ";
            FinSi
        FinPara
        Escribir "";
    FinPara
	
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
    pasajerosPago[TotaldePasajeros] <- precioConDescuento;
    pasajerosPagado[TotaldePasajeros] <- Verdadero;
	
    // Generar QR
	codigoQR <- "TERMINAL|" + dni + "|" + ConvertirATexto(destinoElegido+1) + "|" + ConvertirATexto(asientoElegido+1);
	pasajerosCodigoQR[TotaldePasajeros] <- codigoQR;
	
	// Mostrar QR simple
	Escribir "_________________________________________";
	Escribir "                ????????????";
	Escribir "                ?   QR     ?";
	Escribir "                ?  CODE    ?";
	Escribir "                ?          ?";
	Escribir "                ?  ", Subcadena(dni,1,5), "  ?";
	Escribir "                ?  ", ConvertirATexto(asientoElegido+1), "    ?";
	Escribir "                ????????????";
	Escribir "_________________________________________";
	Escribir "Código QR: ", codigoQR;
	Escribir "_________________________________________";
	
	// Confirmación
	Escribir "===========================================";
	Escribir "¡RESERVA CONFIRMADA Y PAGADA!";
	Escribir "Destino: ", destinos[destinoElegido,1], " -> ", destinos[destinoElegido,2];
	Escribir "Fecha: ", pasajerosFecha[TotaldePasajeros];
	Escribir "Asiento (número interno): ", (asientoElegido + 1);
	Escribir "Precio final: $", precioConDescuento;
	Escribir "===========================================";
	
    // Contadores
    TotaldePasajeros <- TotaldePasajeros + 1;
    ventasPorDestino[destinoElegido] <- ventasPorDestino[destinoElegido] + 1;
FinSubProceso

// =======================
// CONTROL TICKET
// =======================
SubProceso ControlTicket(destinos, descuentos, asientos, pasajerosNombre, pasajerosDNI, pasajerosDestino, pasajerosAsiento, pasajerosPago, pasajerosPagado, pasajerosCodigoQR, ventasPorDestino, TotaldePasajeros Por Referencia, pasajerosFecha)

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
		
        Escribir "-------------------------------------------";
        Escribir "Pasajero: ", pasajerosNombre[encontrado], " | DNI: ", pasajerosDNI[encontrado];
        Escribir "Destino: ", destinos[destinoIdx,1], " -> ", destinos[destinoIdx,2];
        Escribir "Asiento (número interno): ", asientoIdx + 1;
        Escribir "-------------------------------------------";
        Escribir "¿Seguro cancelar? (S/N):";
        Leer confirmacion;
		
        Si confirmacion = "S" O confirmacion = "s" Entonces
            Escribir "ATENCIÓN: La empresa no reconoce reembolso.";
            Escribir "Motivo: cancelación por causas operativas del servicio aéreo.";
            asientos[destinoIdx, asientoIdx] <- 0;
            pasajerosNombre[encontrado] <- "CANCELADO";
            pasajerosPagado[encontrado] <- Falso;
            ventasPorDestino[destinoIdx] <- ventasPorDestino[destinoIdx] - 1;
            Escribir "Cancelado con éxito.";
        Sino
            Escribir "Cancelación abortada.";
        FinSi
    FinSi
FinSubProceso

// =======================
// PARTIDAS
// =======================
SubProceso Partidas(destinos, asientos)
    Definir i, j, libres Como Entero;
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
FinSubProceso

// =======================
// LISTA DE PASAJEROS
// =======================
SubProceso ListaPasajeros(pasajerosNombre, pasajerosDNI, pasajerosDestino, pasajerosAsiento, pasajerosPago, pasajerosPagado, pasajerosCodigoQR, destinos, TotaldePasajeros Por Referencia, pasajerosFecha)
    Definir i, destinoIdx Como Entero;
	
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
