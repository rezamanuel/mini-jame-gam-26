extends Area3D

signal reachedDestination()
var carInArea:VehicleBody3D
var oldCarPosition
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if(carInArea != null):
		if((oldCarPosition - carInArea.position).length() < .02):
			reachedDestination.emit()
			
		oldCarPosition = carInArea.position

func _process(delta):
	pass


func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if(typeof(body) == typeof(VehicleBody3D)):
		carInArea = body
		oldCarPosition = Vector3.ZERO
		
		

func _on_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	carInArea = null
