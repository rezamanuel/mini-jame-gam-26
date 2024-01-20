extends Timer


func formatHrsMin(time:float):
	var hour="%02d" % (int(time) % 12)
	var minute = "%-03d" % ((time - int(time)) * 60)
	var amPm = "AM" if(time >= 12 )else "PM"
	return "%s:%s %s" % [hour, minute, amPm]
	
# Called when the node enters the scene tree for the first time.
func _ready():
	print(formatHrsMin(14.5))
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
