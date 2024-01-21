extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_resume_button_pressed():
	get_tree().paused = false
	queue_free()


func _on_controls_button_pressed():
	var controls = load("res://Scenes/TutorialMenu.tscn").instantiate()
	get_tree().current_scene.add_child(controls)


func _on_main_menu_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
