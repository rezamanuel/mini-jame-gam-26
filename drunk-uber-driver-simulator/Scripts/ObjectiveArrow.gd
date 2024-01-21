extends CSGBox3D

@onready var target = get_tree().root.get_node("game/ramp")



# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(target.global_transform.origin, Vector3.UP, true)
