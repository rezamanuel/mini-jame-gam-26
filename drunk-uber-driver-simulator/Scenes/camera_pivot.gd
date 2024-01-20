extends Node3D

var direction = Vector3.FORWARD
var drunk_var = 3.0

func _physics_process(delta):
	var curr_vel = get_parent().get_linear_velocity()
	curr_vel.y = 0
	if curr_vel.length_squared() > 1:
		direction = lerp(direction, -curr_vel.normalized(), drunk_var * delta)
	global_transform.basis = get_rotation_from_dir(direction)
	
func get_rotation_from_dir(look_direction: Vector3) -> Basis:
	look_direction = look_direction.normalized()
	var x_axis = look_direction.cross(Vector3.UP)
	return Basis(x_axis, Vector3.UP, -look_direction)

func _drink():
	if drunk_var > 0.5:
		drunk_var -= 0.05
	else:
		pass

func _reset_drink():
	drunk_var = 2.5
	
func _sober():
	if drunk_var < 3.0:
		drunk_var += 0.05
	else:
		pass
