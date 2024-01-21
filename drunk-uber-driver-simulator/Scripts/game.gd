extends Node3D

var nissan = preload("res://Scenes/nissan_gtr.tscn")
signal onDrink(bac: int)
var bac = 0
signal drunk(bacPercent:float)
# Called when the node enters the scene tree for the first time.
func _ready():
	var controls = load("res://Scenes/StartTutorialMenu.tscn").instantiate()
	get_tree().current_scene.add_child(controls)
	$Player/CarEngineSound.play()
	$Player/GameMusic.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("escape"):
		print('hello')
		var controls = load("res://Scenes/PauseMenu.tscn").instantiate()
		get_tree().current_scene.add_child(controls)
	if Input.is_action_just_pressed("drink"):
		if bac < 0.39:
			_add_bac(0.03)
			print("Your bac is now " + str(bac))
			$Player/NissanGTR._drink()
			$Player/NissanGTR/camera_pivot._drink()
		else:
			print("You've had too much to drink")
	if bac > 0:
		drunk.emit(bac/.39)

func _add_bac(amount: float):
	bac += amount
	onDrink.emit(amount)

func _reset_bac():
	bac = 0

func _on_sober_timeout():
	if bac > 0:
		_add_bac(-0.03)
	else:
		pass
	
