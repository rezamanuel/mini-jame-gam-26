extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_session_data_target_money_changed(newTarget):
	text = "TONIGHT'S OBJECTIVE: $ %s" % newTarget


func _on_session_data_game_over():
	set_visible(false)
