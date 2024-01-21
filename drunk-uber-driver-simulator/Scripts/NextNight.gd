extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	$SuccessSound.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_restart_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/game.tscn")

func _on_next_night_button_pressed():
	get_tree().paused = false
	queue_free()

func _on_main_menu_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

func _on_quit_button_pressed():
	get_tree().paused = false
	get_tree().quit()
