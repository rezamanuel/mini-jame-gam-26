extends VehicleBody3D

var max_rpm = 1000
var max_torque = 400
var rng = RandomNumberGenerator.new()
var steer_speed = 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	steering = lerp(steering, Input.get_axis("right", "left") * 0.5, steer_speed * delta)
	var acceleration = Input.get_axis("back", "forward")
	var rpm = abs($backleft.get_rpm())
	$backleft.engine_force = acceleration * max_torque * (1 - rpm / max_rpm)
	rpm = abs($backright.get_rpm())
	$backright.engine_force = acceleration * max_torque * (1 - rpm / max_rpm)


func _on_natty_lights_pounded_timeout():
	var randnum = rng.randi_range(0, 2)
	print("Random effect " + str(randnum) + " triggered")
	
	if randnum == 0:
		if $backleft.wheel_friction_slip < 1:
			pass
		else:
			$backleft.wheel_friction_slip -= 0.5
			$backright.wheel_friction_slip -= 0.5
			$frontleft.wheel_friction_slip -= 0.5
			$frontright.wheel_friction_slip -= 0.5
	if randnum == 1:
		$backleft.wheel_roll_influence = rng.randf_range(0.0,1.5)
		$backright.wheel_roll_influence = rng.randf_range(0.0,1.5)
		$frontleft.wheel_roll_influence = rng.randf_range(0.0,1.5)
		$frontright.wheel_roll_influence = rng.randf_range(0.0,1.5)
	if randnum == 2:
		if steer_speed < 0.1:
			pass
		else:
			steer_speed -= 0.1
