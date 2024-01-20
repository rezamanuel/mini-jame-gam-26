extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("reset"):
		_reset_car()

func _reset_car():
	var spawn = self.get_child(0).position
	self.get_child(0).queue_free()
	var nissan = preload("res://Scenes/nissan_gtr.tscn").instantiate()
	self.add_child(nissan)
	self.get_child(1).position = spawn
	print("Reset!")
