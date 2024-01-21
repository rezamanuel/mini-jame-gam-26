extends RichTextLabel

var nightNum = 1

func formatHrsMin(time:float):
	var hour="%02d" % (int(time) % 12)
	var minute = "%02d" % ((time - int(time)) * 60)
	var amPm = "AM" if(time >= 12 )else "PM"
	return "%s:%s %s" % [hour, minute, amPm]
	
func formatGameStateUI(hrsMin:String, nightNum:int):
	return "NIGHT %s
	%s" %[ nightNum, hrsMin]
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_night_cycle_timer_tick(inGameTime):
	text =formatGameStateUI( formatHrsMin(inGameTime), nightNum)


func _on_session_data_night_ended(moneyAmount, nightNumber):
	nightNum = nightNumber



func _on_trip_manager_trip_money_amount_changed(potentialMoney):
	pass # Replace with function body.
