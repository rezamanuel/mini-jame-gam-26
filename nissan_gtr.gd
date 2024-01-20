extends VehicleBody3D

var max_rpm = 1000
var max_torque = 400

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	steering = lerp(steering, Input.get_axis("right", "left") * 0.5, 5 * delta)
	var acceleration = Input.get_axis("back", "forward")
	var rpm = $backleft.get_rpm()
	$backleft.engine_force = acceleration * max_torque * (1 - rpm / max_rpm)
	rpm = $backright.get_rpm()
	$backright.engine_force = acceleration * max_torque * (1 - rpm / max_rpm)
