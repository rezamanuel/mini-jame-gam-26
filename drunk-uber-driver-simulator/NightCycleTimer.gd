extends Timer

@export var initialTimeLeft = 7*30 # 30 secs per hour
var inGameTimeStart:float = 8 # starts at 8PM
@export var inGameTime:float
signal tick(inGameTime:float)
# Called when the node enters the scene tree for the first time.
func _ready():
	wait_time = initialTimeLeft
	start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	inGameTime = inGameTimeStart + 7*((wait_time) - time_left)/210
	tick.emit(inGameTime)
