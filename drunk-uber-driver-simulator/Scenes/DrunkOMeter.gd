extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	value = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_nissan_gtr_on_drink(bac):
	value += 0.03
