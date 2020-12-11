extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


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
