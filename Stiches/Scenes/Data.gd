extends Node

var colSum = []
var rowSum = []
var n;
var groups = [];
var input = {}
var solutionJson = {}

func _ready():
	var output = []
	OS.execute('python', ['script.py', 'input.txt'], true, output)
	print(output)
	
	var json = File.new()
	var solutionJson = File.new()
	
	if not json.file_exists("input.txt.json"):
		print("Missing json file.")
	else:
		json.open("input.txt.json", File.READ)
		var text = json.get_as_text()
		var parsed = JSON.parse(text)
		input = parsed.result
		json.close()
	
	if not solutionJson.file_exists("solutions.json"):
		print("Missing solution file.")
	else:
		json.open("solutions.json", File.READ)
		var text = json.get_as_text()
		var parsed = JSON.parse(text)
		solutionJson = parsed.result
		print(solutionJson)
		json.close()
	
	setInput()
	setSolution()


func setN(numb):
	n = numb

func getN():
	return n

func setInput():
	colSum = input["colSum"]
	rowSum = input["rowSum"]
	setN(input["n"])
	groups = input["groups"]

func setSolution():
	pass


func getGroups():
	return groups

func getColSum():
	return colSum

func getRowSum():
	return rowSum







