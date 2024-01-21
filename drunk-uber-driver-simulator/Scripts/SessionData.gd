extends Node

@onready var playerInventory = $PlayerInventory
var nightNumber:int
var playerMoneyTotal:int

@export var targetMoney:int

signal gameOver()
signal targetMoneyChanged(newTarget:int)
signal totalMoneyChanged(newTotal:int)
signal nightEnded(moneyAmount:int, nightNumber:int)

func get_night_num():
	return nightNumber
# Called when the node enters the scene tree for the first time.
func _ready():
	targetMoney = 400
	targetMoneyChanged.emit(targetMoney)
	playerMoneyTotal = 0
	nightNumber = 1
	#nightEnded.emit(playerInventory.playerMoneyAmount, nightNumber)
	#targetMoney = 1000
	#targetMoneyChanged.emit(targetMoney)
	
# display money, night num, Game over UI. Button to restart or return to main menu.
func game_over():
	$"../Player/GameMusic".stop()
	$TopRightBox.set_visible(false)
	$GameOverScreen.set_visible(true)
	$GameOverScreen/ScreenTimer.start()

func _on_screen_timer_timeout():
	$GameOverScreen.set_visible(false)
	$GameOverMenu.set_visible(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# called when timer exits. game time.. 1hr = 30 secs irl.
func _on_night_cycle_timer_timeout():
	playerMoneyTotal += playerInventory.playerMoneyAmount
	totalMoneyChanged.emit(playerMoneyTotal)
	if(playerInventory.playerMoneyAmount >= targetMoney):
		# great success, move onto next night.
		nightNumber += 1
		nightEnded.emit(playerInventory.playerMoneyAmount, nightNumber)
		targetMoney = targetMoney*nightNumber - (targetMoney*.5) # edit this line to adjust money goal difficulty
		targetMoneyChanged.emit(targetMoney)
		playerInventory.zeroMoney()
		%NissanGTR._reset_car()
		var next_night = load("res://Scenes/next_night.tscn").instantiate()
		get_tree().current_scene.add_child(next_night)
	else:
		nightEnded.emit(playerInventory.playerMoneyAmount, nightNumber)
		gameOver.emit()
		game_over()
	# cleans up any current tasks, calculates if Game Over, score.
