extends Node3D

@onready var animPlayer = $AnimationPlayer
signal PassangerPickup()

var m_isCarStopped = false
# Called when the node enters the scene tree for the first time.
func _ready():
	animPlayer.play("wave")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_passanger_pickup_area_car_entered(isCarStopped, carPosition):
	look_at(carPosition, Vector3.UP, true)
	m_isCarStopped = isCarStopped
	if(isCarStopped ):
		animPlayer.play("run",-1,1.6)
	else:
		animPlayer.play("wave")


func _on_area_3d_body_entered(body):
	if(typeof(body) == typeof(VehicleBody3D) && m_isCarStopped):
		PassangerPickup.emit()
		
