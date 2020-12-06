extends Node2D

var cerchio = 0 #0 false, 1 true
var attaccato = false
var stiches
var i
var j


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		self.on_click()

func on_click():
	if cerchio:
		get_parent().get_parent().staccaVicini(self)
		cerchio = 0
		$Area2D/AnimatedSprite.play("default")
	else:
		get_parent().get_parent().attaccaVicini(self)
		cerchio = 1
		$Area2D/AnimatedSprite.play("cerchio")
		

func colora(colore):
	match colore:
		"azzurro":
			self.modulate.r = 0
			self.modulate.g = 0
			self.modulate.b = 155
		"rosso":
			self.modulate.r = 255
			self.modulate.g = 0
			self.modulate.b = 0
		"giallo":
			self.modulate.r = 255
			self.modulate.g = 241
			self.modulate.b = 0
		"verde":
			self.modulate.r = 0
			self.modulate.g = 255
			self.modulate.b = 0
		"bianco":
			self.modulate.r = 255
			self.modulate.g = 255
			self.modulate.b = 255

func getCerchio():
	return cerchio

func getAttaccato():
	return attaccato

func setAttaccato(boolean):
	attaccato = boolean

func togliCerchio():
	cerchio = 0
	$Area2D/AnimatedSprite.play("default")

func mettiCerchio():
	cerchio = 1
	$Area2D/AnimatedSprite.play("cerchio")

func setCoord(x,y):
	i = y
	j = x

func getI():
	return i

func getJ():
	return j






