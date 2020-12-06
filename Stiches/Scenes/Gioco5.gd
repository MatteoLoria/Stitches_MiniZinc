extends Node2D


var blocchi = []
var n = 5
var thisRow
var thisCol
var blocksStitches = []
var cerchioPrecedente = null
var iteratore = 0

func _ready():
	thisRow = $RowSum.get_children()
	thisCol = $ColSum.get_children()
	var children = $Blocchi.get_children()
	var index = 0
	
	for i in range(n):
		var blocchiTemp = []
		for j in range(n):
			children[index].setCoord(j,i)
			blocchiTemp.push_back(children[index])
			index = index + 1
		blocchi.push_back(blocchiTemp)
	
	coloraGruppi()
	setColSum()
	setRowSum()


func _process(delta):
	controllaRighe()
	controllaColonne()

func coloraGruppi():
	var groups = Data.getGroups()
	
	for i in range(n):
		for j in range(n):
			match groups[i][j]:
				1:
					blocchi[i][j].colora("azzurro")
				2:
					blocchi[i][j].colora("rosso")
				3:
					blocchi[i][j].colora("giallo")
				4:
					blocchi[i][j].colora("verde")
				5:
					blocchi[i][j].colora("bianco")

func setColSum():
	var colSum = Data.getColSum()

	
	for i in range(n):
		thisCol[i].text = str(colSum[i])

func setRowSum():
	var rowSum = Data.getRowSum()
	
	
	for i in range(n):
		thisRow[i].text = str(rowSum[i])

func controllaRighe():
	
	for i in range(n):
		var count = 0
		for j in range(n):
			count += blocchi[i][j].getCerchio()
		if count > int(thisRow[i].text):
			thisRow[i].modulate.r = 255
			thisRow[i].modulate.g = 0
			thisRow[i].modulate.b = 0
		else:
			thisRow[i].modulate.r = 255
			thisRow[i].modulate.g = 255
			thisRow[i].modulate.b = 255

func controllaColonne():
	
	for i in range(n):
		var count = 0
		for j in range(n):
			count += blocchi[j][i].getCerchio()
		if count > int(thisCol[i].text):
			thisCol[i].modulate.r = 255
			thisCol[i].modulate.g = 0
			thisCol[i].modulate.b = 0
		else:
			thisCol[i].modulate.r = 255
			thisCol[i].modulate.g = 255
			thisCol[i].modulate.b = 255
			
func disegnaStitch(cerchioAttuale, cerchioPrecedente):
	var areaAttuale = Data.getGroups()[cerchioAttuale.getI()][cerchioAttuale.getJ()]
	var areaPrecedente = Data.getGroups()[cerchioPrecedente.getI()][cerchioPrecedente.getJ()]
	if areaAttuale != areaPrecedente:
		cerchioAttuale.setAttaccato(true)
		cerchioPrecedente.setAttaccato(true)
		var stiches_scene = load("res://Scenes/Stiches.tscn")
		var stiches = stiches_scene.instance()
		add_child(stiches)
		var blockStitchesTemp = [cerchioAttuale, cerchioPrecedente, stiches]
		blocksStitches.push_back(blockStitchesTemp)
		if cerchioAttuale.position.x > cerchioPrecedente.position.x:
			stiches.position.x = cerchioPrecedente.position.x + 30
			stiches.position.y = cerchioPrecedente.position.y
		else:
			stiches.position.x = cerchioAttuale.position.x + 30
			stiches.position.y = cerchioAttuale.position.y
		if cerchioAttuale.position.y > cerchioPrecedente.position.y:
			stiches.rotation_degrees = -90
			stiches.position.x = cerchioAttuale.position.x
			stiches.position.y = cerchioAttuale.position.y - 30
		elif cerchioAttuale.position.y < cerchioPrecedente.position.y:
			stiches.rotation_degrees = -90
			stiches.position.x = cerchioPrecedente.position.x
			stiches.position.y = cerchioPrecedente.position.y - 30
		return true
	return false

func attaccaVicini(cerchioAttuale):
	var i = cerchioAttuale.getI()
	var j = cerchioAttuale.getJ()
	var check = false
	if(i!= 0 and blocchi[i - 1][j].getCerchio() == 1 and not blocchi[i-1][j].getAttaccato()):
		check = disegnaStitch(cerchioAttuale, blocchi[i - 1][j])
	if(i!= n-1 and blocchi[i + 1][j].getCerchio() == 1 and not blocchi[i+1][j].getAttaccato() and not check):
		check = disegnaStitch(cerchioAttuale, blocchi[i + 1][j])
	if(j!= 0 and blocchi[i][j-1].getCerchio() == 1 and not blocchi[i][j-1].getAttaccato() and not check):
		check = disegnaStitch(cerchioAttuale, blocchi[i][j - 1])
	if(j!= n-1 and blocchi[i][j+1].getCerchio() == 1 and not blocchi[i][j+1].getAttaccato() and not check):
		check = disegnaStitch(cerchioAttuale, blocchi[i][j + 1])

func staccaVicini(cerchio):
	var index = -1
	for i in range(blocksStitches.size()):
		if cerchio == blocksStitches[i][0] \
		or cerchio == blocksStitches[i][1]:
			blocksStitches[i][2].queue_free()
			blocksStitches[i][0].setAttaccato(false)
			blocksStitches[i][1].setAttaccato(false)
			blocksStitches[i][0].togliCerchio()
			blocksStitches[i][1].togliCerchio()
			index = i
	if index > -1:
		blocksStitches.remove(index)
		




