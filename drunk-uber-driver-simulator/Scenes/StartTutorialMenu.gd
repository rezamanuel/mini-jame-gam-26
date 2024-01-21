extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_tree().paused = false
	queue_free()
