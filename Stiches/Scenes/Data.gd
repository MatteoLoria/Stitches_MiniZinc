extends Node

var colSum = []
var rowSum = []
var n;
var groups = [];
var input = {}
var solutionJson = {}
var solution = []
var implicitSol = []

func avviaGioco(n):
	var output = []
	OS.execute('python', ['provaAPI.py', n], true, output)
	print(output)
	
	var json = File.new()
	
	if not json.file_exists("finalinput.json"):
		print("Missing json file.")
	else:
		json.open("finalinput.json", File.READ)
		var text = json.get_as_text()
		var parsed = JSON.parse(text)
		input = parsed.result
		#print(input)
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
	implicitSol = input["results"]
	solution = input["results_as_digits"]


func getGroups():
	return groups

func getColSum():
	return colSum

func getRowSum():
	return rowSum

func getSol():
	return solution

func getImplSol():
	return implicitSol






