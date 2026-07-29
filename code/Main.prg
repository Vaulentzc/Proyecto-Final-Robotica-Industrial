' Programa de implementación
Global Integer i

Global Integer alm(20)
Global Integer baq(20)
Global Integer NumComponentes


Function main

Motor On
Power High
Accel 100, 100
Speed 10

Home

Call CargarComponentes
Call EnsambleComponentes

Home

Fend


Function CargarComponentes

' alm(i) = posición del componente en el almacén
' baq(i) = posición destino en la baquela
'
' Almacén: 6 columnas x 6 filas = 36 posiciones
' Baquela: 27 columnas x 22 filas = 594 posiciones

NumComponentes = 10

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

' sensor

alm(9) = 26

baq(9) = 429

' Integrado 3

alm(10) = 27

baq(10) = 133

Fend


Function EnsambleComponentes

' Pallet 1: almacén de componentes, 6 columnas x 6 filas
Pallet 1, Almacen_Origin, Almacen_X, Almacen_Y, 6, 6

' Pallet 2: baquela universal, 27 columnas x 22 filas
Pallet 2, baquela_Origin, baquela_X, baquela_Y, 27, 22


For i = 1 To NumComponentes

' Recoger componente del almacén

' Jump Pallet(1, alm(i)) :Z(-10) LimZ -1
Go Pallet(1, alm(i)) :Z(-60)
Speed 1
Jump Pallet(1, alm(i))
Wait 2
Speed 10
Call Tomar
Wait 2


' Llevar componente a la baquela
Go Pallet(1, alm(i)) :Z(-60)
Go Pallet(2, baq(i)) :Z(-60)
Speed 1
Jump Pallet(2, baq(i))
Wait 2
Speed 10
Call Soltar
Wait 2
Go Pallet(2, baq(i)) :Z(-60)

Next i

Fend


Function Tomar

On DO_09

Fend


Function Soltar

Off DO_09

Fend