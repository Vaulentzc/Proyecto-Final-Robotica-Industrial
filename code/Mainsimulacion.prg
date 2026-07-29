Global Integer i

Global Integer alm(20)
Global Integer baq(20)
Global Integer NumComponentes


Function main

	Motor On
	Power High
	Accel 100, 100
	Speed 50

	Home
	
	Call CargarComponentes
	Call EnsambleComponentes

	Home

Fend


Function CargarComponentes

	NumComponentes = 10

	' --------------------------------------------------
	' alm(i) = posición del componente en el almacén
	' baq(i) = posición destino en la baquela
	'
	' Almacén: 6 columnas x 6 filas
	' Baquela: 27 columnas x 22 filas
	' --------------------------------------------------

	' Componente 1: bornera1alm
	' Bornera 1

	alm(1) = 2
	baq(1) = 140
	
	' Bornera 2
	
	alm(2) = 3
	baq(2) = 329
	
	
	' Bornera 3
	alm(3) = 8
	baq(3) = 462
	
	' Integrado 1
	
	alm(4) = 9
	baq(4) = 147
	
	' Integrado 2
	
	alm(5) = 14
	baq(5) = 442
	
	' Cristal 1
	
	alm(6) = 15
	baq(6) = 44
	
	' Cristal 2
	
	alm(7) = 20
	baq(7) = 285
	
	' Cristal 3
	
	alm(8) = 21
	baq(8) = 557
	
	' sensor
	
	alm(9) = 26
	baq(9) = 481
	
	' Integrado 3
	
	alm(10) = 27
	baq(10) = 133

Fend


Function EnsambleComponentes

	Pallet 1, Almacen_Origin, Almacen_X, Almacen_Y, 6, 6
	Pallet 2, baquela_Origin, baquela_X, baquela_Y, 27, 22


	For i = 1 To NumComponentes

		' --------------------------------------------------
		' Ir encima del componente en el almacén
		' --------------------------------------------------
		Go Pallet(1, alm(i)) :Z(-60)
		Wait 1
		
		' Bajar hasta el componente
		Jump Pallet(1, alm(i))
		Wait 1
		
		' Activar electroimán
		Call Tomar
		Wait 1
		
		' Pegar el CAD correspondiente al Tool 1
		Call PickCAD
		Wait 1
		
		' Subir con el componente
		Go Pallet(1, alm(i)) :Z(-60)
		Wait 1

		' Ir encima de la posición destino en la baquela
		Go Pallet(2, baq(i)) :Z(-60)
		Wait 1

		' Bajar a la posición destino
		Jump Pallet(2, baq(i))
		Wait 1
		
		' Soltar electroimán
		Call Soltar
		Wait 1
		
		' Dejar el CAD fijo en la baquela
		Call PlaceCAD
		Wait 1
		
		' Subir sin el componente
		Go Pallet(2, baq(i)) :Z(-60)
		Wait 1

	Next i

Fend


Function PickCAD

	Select i

		Case 1
			SimSet Junior.Pick, sensoralm, 1

		Case 2
			SimSet Junior.Pick, bornera2alm, 1

		Case 3
			SimSet Junior.Pick, bornera3alm, 1

		Case 4
			SimSet Junior.Pick, dip16_1alm, 1

		Case 5
			SimSet Junior.Pick, dip16_2alm, 1

		Case 6
			SimSet Junior.Pick, cristal1alm, 1

		Case 7
			SimSet Junior.Pick, cristal2alm, 1

		Case 8
			SimSet Junior.Pick, cristal3alm, 1

		Case 9
			SimSet Junior.Pick, bornera1alm, 1

		Case 10
			' Cambia este nombre si tu décimo CAD tiene otro nombre
			SimSet Junior.Pick, dip8alm, 1

	Send

Fend


Function PlaceCAD

	Select i

		Case 1
			SimSet Junior.Place, sensoralm

		Case 2
			SimSet Junior.Place, bornera2alm

		Case 3
			SimSet Junior.Place, bornera3alm

		Case 4
			SimSet Junior.Place, dip16_1alm

		Case 5
			SimSet Junior.Place, dip16_2alm

		Case 6
			SimSet Junior.Place, cristal1alm

		Case 7
			SimSet Junior.Place, cristal2alm

		Case 8
			SimSet Junior.Place, cristal3alm

		Case 9
			SimSet Junior.Place, bornera1alm

		Case 10
			' Cambia este nombre si tu décimo CAD tiene otro nombre
			SimSet Junior.Place, dip8alm

	Send

Fend


Function Tomar

	' Off DO_09 = activa electroimán / toma componente
	Off DO_09

Fend


Function Soltar

	' On DO_09 = desactiva electroimán / suelta componente
	On DO_09

Fend