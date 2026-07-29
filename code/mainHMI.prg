' =========================================================
' mainHMI.prg
' Code-behind del formulario mainHMI
' EPSON T3 401S - Ensamble de PCB
' =========================================================


' =========================================================
' EVENTO DE CARGA DE LA PANTALLA
' =========================================================

Function mainHMI_Load(Sender$ As String)

    GSet mainHMI.lblEstado.Text, "Estado: IDLE"
    GSet mainHMI.lblOperacion.Text, "Operación: Esperando inicio"
    GSet mainHMI.lblComponente.Text, "Componente actual: 0"
    GSet mainHMI.lblAlarma.Text, "Alarma: Sin alarmas"
    GSet mainHMI.lblReceta.Text, "Receta: PCB-01"
    GSet mainHMI.lblProgreso.Text, "Progreso: 0 / 10"

Fend


' =========================================================
' BOTÓN START
' =========================================================

Function mainHMI_btnStart_Click(Sender$ As String)

    ' Solo inicia si la tarea 5 está libre
    If TaskState(5) = 0 Then

        GSet mainHMI.lblEstado.Text, "Estado: RUN"
        GSet mainHMI.lblOperacion.Text, "Operación: Iniciando ensamble"
        GSet mainHMI.lblComponente.Text, "Componente actual: 0"
        GSet mainHMI.lblAlarma.Text, "Alarma: Sin alarmas"
        GSet mainHMI.lblProgreso.Text, "Progreso: 0 / 10"

        Print "Tarea de ensamble iniciada"

        ' Ejecuta el ensamble en Task 5
        Xqt 5, TareaEnsamble

    Else

        GSet mainHMI.lblAlarma.Text, "Alarma: Ensamble ya en curso"

        Print "El ensamble ya está en curso."

    EndIf

Fend


' =========================================================
' BOTÓN STOP
' =========================================================

Function mainHMI_btnStop_Click(Sender$ As String)

    ' Detiene la tarea de ensamble
    Quit 5

    ' Desactiva el gripper / ventosa
    Off DO_09

    GSet mainHMI.lblEstado.Text, "Estado: IDLE"
    GSet mainHMI.lblOperacion.Text, "Operación: Ciclo detenido"
    GSet mainHMI.lblAlarma.Text, "Alarma: Proceso detenido por operador"

    Print "Ciclo de ensamble detenido."

Fend


' =========================================================
' BOTÓN HOME
' =========================================================

Function mainHMI_btnHome_Click(Sender$ As String)

    ' Solo permite HOME si no hay ensamble en ejecución
    If TaskState(5) = 0 Then

        GSet mainHMI.lblOperacion.Text, "Operación: Moviendo a HOME"
        GSet mainHMI.lblAlarma.Text, "Alarma: Sin alarmas"

        Motor On

        Home

        GSet mainHMI.lblEstado.Text, "Estado: IDLE"
        GSet mainHMI.lblOperacion.Text, "Operación: Robot en HOME"

        Print "Robot en posición Home."

    Else

        GSet mainHMI.lblAlarma.Text, "Alarma: Detenga el proceso antes de HOME"

        Print "Detenga el proceso primero usando STOP."

    EndIf

Fend


' =========================================================
' BOTÓN RESET
' =========================================================

Function mainHMI_tbnReset_Click(Sender$ As String)

    Reset

    Off DO_09

    GSet mainHMI.lblEstado.Text, "Estado: IDLE"
    GSet mainHMI.lblOperacion.Text, "Operación: Esperando inicio"
    GSet mainHMI.lblComponente.Text, "Componente actual: 0"
    GSet mainHMI.lblAlarma.Text, "Alarma: Sin alarmas"
    GSet mainHMI.lblReceta.Text, "Receta: PCB-01"
    GSet mainHMI.lblProgreso.Text, "Progreso: 0 / 10"

    Print "Sistema reseteado."

Fend


' =========================================================
' TAREA PRINCIPAL DE ENSAMBLE
' =========================================================

Function TareaEnsamble

    GSet mainHMI.lblEstado.Text, "Estado: RUN"
    GSet mainHMI.lblOperacion.Text, "Operación: Ejecutando HOME"
    GSet mainHMI.lblAlarma.Text, "Alarma: Sin alarmas"

    Print "Tarea de ensamble iniciada"

    Home

    Print "Home ejecutado"

    GSet mainHMI.lblOperacion.Text, "Operación: Cargando receta"

    Call CargarComponentes

    Print "Componentes cargados"

    GSet mainHMI.lblOperacion.Text, "Operación: Ensamblando PCB"

    Call EnsambleComponentes

    GSet mainHMI.lblOperacion.Text, "Operación: Retornando a HOME"

    Home

    GSet mainHMI.lblEstado.Text, "Estado: DONE"
    GSet mainHMI.lblOperacion.Text, "Operación: Ensamble finalizado"
    GSet mainHMI.lblComponente.Text, "Componente actual: 10"
    GSet mainHMI.lblProgreso.Text, "Progreso: 10 / 10"
    GSet mainHMI.lblAlarma.Text, "Alarma: Sin alarmas"

    Print "Ensamble Finalizado"

Fend


' =========================================================
' CARGA DE COMPONENTES / RECETA
' =========================================================

Function CargarComponentes

    NumComponentes = 10

    GSet mainHMI.lblReceta.Text, "Receta: PCB-01"
    GSet mainHMI.lblProgreso.Text, "Progreso: 0 / " + Str$(NumComponentes)

    ' Bornera 1
    alm(1) = 2
    baq(1) = 30

    ' Bornera 2
    alm(2) = 3
    baq(2) = 273

    ' Bornera 3
    alm(3) = 8
    baq(3) = 516

    ' Integrado 1
    alm(4) = 9
    baq(4) = 145

    ' Integrado 2
    alm(5) = 14
    baq(5) = 442

    ' Cristal 1
    alm(6) = 15
    baq(6) = 44

    ' Cristal 2
    alm(7) = 20
    baq(7) = 287

    ' Cristal 3
    alm(8) = 21
    baq(8) = 557

    ' Sensor
    alm(9) = 26
    baq(9) = 429

    ' Integrado 3
    alm(10) = 27
    baq(10) = 133

Fend


' =========================================================
' RUTINA DE ENSAMBLE
' =========================================================

Function EnsambleComponentes

    ' Pallet 1:
    ' Almacén de componentes
    ' 6 columnas x 6 filas

    Pallet 1, Almacen_Origin, Almacen_X, Almacen_Y, 6, 6

    ' Pallet 2:
    ' Baquela universal
    ' 27 columnas x 22 filas

    Pallet 2, baquela_Origin, baquela_X, baquela_Y, 27, 22


    For i = 1 To NumComponentes

        ' -------------------------------------------------
        ' COMPONENTE ACTUAL
        ' -------------------------------------------------

        GSet mainHMI.lblComponente.Text, "Componente actual: " + Str$(i)


        ' -------------------------------------------------
        ' IR AL COMPONENTE
        ' -------------------------------------------------

        GSet mainHMI.lblOperacion.Text, "Operación: Buscando componente"

        Go Pallet(1, alm(i)) :Z(-60)

        Speed 10


        ' -------------------------------------------------
        ' PICK
        ' -------------------------------------------------

        GSet mainHMI.lblOperacion.Text, "Operación: Realizando PICK"

        Jump Pallet(1, alm(i))

        Wait 2

        Speed 30

        Call Tomar

        Wait 2


        ' -------------------------------------------------
        ' TRASLADO HACIA PCB
        ' -------------------------------------------------

        GSet mainHMI.lblOperacion.Text, "Operación: Trasladando componente"

        Go Pallet(1, alm(i)) :Z(-60)

        Go Pallet(2, baq(i)) :Z(-60)


        ' -------------------------------------------------
        ' PLACE
        ' -------------------------------------------------

        Speed 10

        GSet mainHMI.lblOperacion.Text, "Operación: Realizando PLACE"

        Jump Pallet(2, baq(i))

        Wait 2

        Speed 30

        Call Soltar

        Wait 2


        ' -------------------------------------------------
        ' COMPONENTE INSTALADO
        ' -------------------------------------------------

        GSet mainHMI.lblProgreso.Text, "Progreso: " + Str$(i) + " / " + Str$(NumComponentes)

        GSet mainHMI.lblOperacion.Text, "Operación: Componente colocado"

        Go Pallet(2, baq(i)) :Z(-60)

    Next i

Fend


' =========================================================
' GRIPPER / VENTOSA
' =========================================================

Function Tomar

    On DO_09

Fend


Function Soltar

    Off DO_09

Fend


' =========================================================
' EVENTOS CLICK DE LOS LABELS
' No realizan ninguna acción
' =========================================================

Function mainHMI_lblEstado_Click(Sender$ As String)

Fend


Function mainHMI_lblOperacion_Click(Sender$ As String)

Fend


Function mainHMI_lblComponente_Click(Sender$ As String)

Fend


Function mainHMI_lblAlarma_Click(Sender$ As String)

Fend


Function mainHMI_lblReceta_Click(Sender$ As String)

Fend


Function mainHMI_lblProgreso_Click(Sender$ As String)

Fend
