extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	value = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_game_on_drink(bac):
	value += bac

func _reset_progress():
	value = 0


func _on_timer_timeout():
	pass # Replace with function body.
