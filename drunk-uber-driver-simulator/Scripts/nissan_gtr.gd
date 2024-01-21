extends VehicleBody3D

var max_rpm = 1000
var max_torque = 400
var rng = RandomNumberGenerator.new()
var steer_speed = 5
@onready var left_smoke = $backleft/Smoke
@onready var right_smoke = $backright/Smoke
var spawn_position = Vector3(0,1.5,0)
var effects = []
var skid_sound_effect_playing = false

signal crash
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	steering = lerp(steering, Input.get_axis("right", "left") * 0.5, steer_speed * delta)
	var acceleration = Input.get_axis("back", "forward")
	var rpm = abs($backleft.get_rpm())
	$backleft.engine_force = acceleration * max_torque * (1 - rpm / max_rpm)
	rpm = abs($backright.get_rpm())
	$backright.engine_force = acceleration * max_torque * (1 - rpm / max_rpm)
	if $backright.get_skidinfo() < 1:
		left_smoke.emitting = true
	else:
		left_smoke.emitting = false
	if $backleft.get_skidinfo() < 1:
		right_smoke.emitting = true
	else:
		right_smoke.emitting = false
	if !skid_sound_effect_playing:
		if $backright.get_skidinfo() < 0.5 or $backleft.get_skidinfo() < 0.5:
			skid_sound_effect_playing = true
			_play_random_tire_sound_effect()
	if ($backright.get_skidinfo() == 1 and $backleft.get_skidinfo() == 1) or ($backright.get_skidinfo() == 0 and $backleft.get_skidinfo() == 0):
		skid_sound_effect_playing = false
		_stop_playing_tire_sound_effect()
		
	
		

func _process(_delta):
	if Input.is_action_just_pressed("reset"):
		_reset_car()

func _on_body_entered(_body):
	if linear_velocity.length() < 10:
		$"../CollisionSound".play()
		crash.emit()

func _on_collision_sound_finished():
	pass # Replace with function body.

func _drink():
	$"../DrinkingSound".play()
	var randnum = rng.randi_range(0, 2)
	effects.append(randnum)
	_change_car_physics(randnum, 1)
	print("Random effect " + str(randnum) + " triggered")
	
func _reset_car():
	rotation = Vector3(0, rotation.y, 0)
	linear_velocity = Vector3(0, 0, 0)
	while effects.size() > 0:
		_sober()
	$camera_pivot._reset_drink()
	print("Reset!")
	$"../../SessionData/TopRightBox/HBoxContainer/Control2/DrunkOMeter"._reset_progress()
	$"../.."._reset_bac()


func _on_sober_timeout():
	if effects.size() > -1:
		$camera_pivot._sober()
		_sober()
	else:
		pass

func _sober():
	if effects.size() > 0:
		var num = effects.pop_front()
		_change_car_physics(num, -1)
	
func _change_car_physics(num: int, mod: int):
	if num == 0:
		$backleft.wheel_friction_slip -= 0.6 * mod
		$backright.wheel_friction_slip -= 0.6 * mod
	if num == 1:
		$backleft.wheel_roll_influence += 0.25 * mod
		$backright.wheel_roll_influence += 0.25 * mod
		$frontleft.wheel_roll_influence += 0.25 * mod
		$frontright.wheel_roll_influence += 0.25 * mod
	if num == 2:
		steer_speed -= 0.2 * mod
		
func _play_random_tire_sound_effect():
	var randnum = rng.randi_range(0, 3)
	if randnum == 0:
		$"TireSkid1".play()
	elif randnum == 1:
		$"TireSkid2".play()
	elif randnum == 2:
		$"TireSkid3".play()
	else:
		$"TireSkid4".play()
	
	
func _stop_playing_tire_sound_effect():
	$"TireSkid1".stop()
	$"TireSkid2".stop()
	$"TireSkid3".stop()
	$"TireSkid4".stop()
