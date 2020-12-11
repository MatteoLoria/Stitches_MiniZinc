extends Button

#Gioco5 : 1,2,3
#Gioco7: 4, 6
#Gioco10: 5,7,8
#Gioco15: 9,10

var dictGioco = {}


# Called when the node enters the scene tree for the first time.
func _ready():
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Gioco5_pressed():
	if "5" in self.name:
		SceneManager.goto_scene("res://Scenes/Gioco5.tscn")
	elif "7" in self.name:
		SceneManager.goto_scene("res://Scenes/Gioco7.tscn")
	elif "10" in self.name:
		SceneManager.goto_scene("res://Scenes/Gioco10.tscn")
