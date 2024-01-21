extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func move_on():
	var game_over_menu = load("res://Scenes/GameOverMenu.tscn").instantiate()
	get_tree().current_scene.add_child(game_over_menu)
