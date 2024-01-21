extends CSGBox3D

#@onready var target = get_tree().root.get_node("$map_image/building_019_002")



# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(target != null):
		look_at(target.global_transform.origin, Vector3.UP, true)


func _on_trip_manager_route_to_node(destinationNode):
	target = destinationNode
