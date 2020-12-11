extends Node

var colSum = []
var rowSum = []
var n;
var groups = [];
var input = {}

func _ready():
	var output = []
	OS.execute('batch.bat', [], true, output) #non va, provare con un file bat? 
	print(output)
	
	var json = File.new()
	
	if not json.file_exists("input.txt.json"):
		print("Missing json file.")
	else:
		json.open("input.txt.json", File.READ)
		var text = json.get_as_text()
		var parsed = JSON.parse(text)
		input = parsed.result
		json.close()
	
	setInput()


func setN(numb):
	n = numb

func getN():
	return n

func setInput():
	colSum = input["colSum"]
	rowSum = input["rowSum"]
	setN(input["n"])
	groups = input["groups"]


func getGroups():
	return groups

func getColSum():
	return colSum

func getRowSum():
	return rowSum







