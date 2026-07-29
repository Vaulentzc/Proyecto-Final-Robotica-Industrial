' --- VARIABLES GLOBALES ---
Global Integer i
Global Integer alm(20)
Global Integer baq(20)
Global Integer NumComponentes

' --- FUNCIÓN PRINCIPAL ---
Function main
    ' 1. Prepara el robot
    Motor On
    Power High
    Accel 100, 100
    Speed 10
    
    ' 2. Abre tu interfaz gráfica (se asume que el formulario se llama mainHMI)
    GShow mainHMI
    
    ' 3. Bucle infinito para mantener el programa vivo y la ventana abierta
    Do
        Wait 0.1
    Loop
Fend
