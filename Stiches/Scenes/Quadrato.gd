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
		"blu":
			modulate = Color( 0, 0, 1, 1 )
		"rosso":
			modulate = Color( 1, 0, 0, 1 )
		"giallo":
			modulate = Color( 1, 1, 0, 1 )
		"verde":
			modulate = Color( 0, 1, 0, 1 )
		"bianco":
			modulate = Color( 1, 1, 1, 1 )
		"viola":
			modulate = Color( 0.58, 0.44, 0.86, 1 )
		"azzurro":
			modulate = Color( 0.53, 0.81, 0.98, 1 )
		"arancio":
			modulate = Color( 1, 0.65, 0, 1 )
		"ivory":
			modulate = Color( 1, 1, 0.94, 1 )
		"peru":
			modulate = Color( 0.8, 0.52, 0.25, 1 )
		"turquoise":
			modulate = Color( 0.25, 0.88, 0.82, 1 )
		"darkviolet":
			modulate = Color( 0.58, 0, 0.83, 1 )
		"khaki":
			modulate = Color( 0.94, 0.9, 0.55, 1 )
		"lavander":
			modulate = Color( 0.9, 0.9, 0.98, 1 )
		"lawngreen":
			modulate = Color( 0.49, 0.99, 0, 1 )
		"lemonchiffon":
			modulate = Color( 1, 0.98, 0.8, 1 )
		"lightcoral":
			modulate = Color( 0.94, 0.5, 0.5, 1 )
		"lightgoldenrod":
			modulate = Color( 0.98, 0.98, 0.82, 1 )
		"lightpink":
			modulate = Color( 1, 0.71, 0.76, 1 )
		"magenta":
			modulate = Color( 1, 0, 1, 1 )
		"mistyrose":
			modulate = Color( 1, 0.89, 0.88, 1 )
		
		

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






