extends Node

@onready var playerInventory = $PlayerInventory
var nightNumber:int

@export var targetMoney:int

signal targetMoneyChanged(newTarget:int)
signal nightEnded(moneyAmount:int, nightNumber:int)
func get_night_num():
	return nightNumber
# Called when the node enters the scene tree for the first time.
func _ready():
	targetMoney = 500
	targetMoneyChanged.emit(targetMoney)
	nightNumber = 1
	
# display money, night num, Game over UI. Button to restart or return to main menu.
func game_over():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# called when timer exits. game time.. 1hr = 30 secs irl.


func _on_night_cycle_timer_timeout():
	if(playerInventory.playerMoney >= targetMoney):
		# great success, move onto next night.
		nightNumber += 1
		targetMoney = targetMoney*nightNumber - (targetMoney*.5) # edit this line to adjust money goal difficulty
		targetMoneyChanged.emit(targetMoney)
		nightEnded.emit(playerInventory.playerMoney, nightNumber)
	else:
		game_over()
	# cleans up any current tasks, calculates if Game Over, score.



