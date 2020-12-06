extends Node

var colSum = [3,1,3,1,2]
var rowSum = [2,1,2,4,1]
var n;
var groups = [];

func _ready():
	setN(5)
	setTemp()

func setN(numb):
	n = numb

func setTemp():
	
	var tempGroups1 = [1,1,1,2,2]
	var tempGroups2 = [1,1,1,1,2]
	var tempGroups3 = [3,3,3,1,1]
	var tempGroups4 = [4,3,5,5,5]
	var tempGroups5 = [4,3,3,3,3]
	
	groups.push_back(tempGroups1)
	groups.push_back(tempGroups2)
	groups.push_back(tempGroups3)
	groups.push_back(tempGroups4)
	groups.push_back(tempGroups5)

func getGroups():
	return groups

func getColSum():
	return colSum

func getRowSum():
	return rowSum







