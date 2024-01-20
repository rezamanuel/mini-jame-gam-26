extends Node3D

var nissan = preload("res://Scenes/nissan_gtr.tscn")
signal onDrink(bac: int)
var bac = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

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
			$NissanGTR._drink()
		else:
			print("You've had too much to drink")

func _add_bac(amount: float):
	bac += amount
	onDrink.emit(amount)

func _reset_bac():
	bac = 0
