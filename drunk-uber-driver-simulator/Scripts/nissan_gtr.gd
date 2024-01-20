extends VehicleBody3D

var max_rpm = 1000
var max_torque = 400
var rng = RandomNumberGenerator.new()
var steer_speed = 5
var spawn_position = Vector3(0,1.5,0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	steering = lerp(steering, Input.get_axis("right", "left") * 0.5, steer_speed * delta)
	var acceleration = Input.get_axis("back", "forward")
	var rpm = abs($backleft.get_rpm())
	$backleft.engine_force = acceleration * max_torque * (1 - rpm / max_rpm)
	rpm = abs($backright.get_rpm())
	$backright.engine_force = acceleration * max_torque * (1 - rpm / max_rpm)

func _process(_delta):
	if Input.is_action_just_pressed("reset"):
		_reset_car()

func _on_body_entered(_body):
	$"../CollisionSound".play()
	print("Crashed!")

func _on_collision_sound_finished():
	pass # Replace with function body.

func _drink():
	var randnum = rng.randi_range(0, 2)
	print("Random effect " + str(randnum) + " triggered")
	if randnum == 0:
		if $backleft.wheel_friction_slip < 1:
			pass
		else:
			$backleft.wheel_friction_slip -= 0.5
			$backright.wheel_friction_slip -= 0.5
	if randnum == 1:
		if $backleft.wheel_roll_influence > 1.5:
			pass
		else:
			$backleft.wheel_roll_influence += 0.1
			$backright.wheel_roll_influence += 0.1
			$frontleft.wheel_roll_influence += 0.1
			$frontright.wheel_roll_influence += 0.1
	if randnum == 2:
		if steer_speed < 0.1:
			pass
		else:
			steer_speed -= 0.1

func _reset_car():
	rotation = Vector3(0, rotation.y, 0)
	print("Reset!")
	get_parent()._reset_bac()
	$"../DrunkOMeter"._reset_progress()
