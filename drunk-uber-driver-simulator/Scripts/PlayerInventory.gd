extends Node

@export var playerMoneyAmount:int

signal moneyChanged(playerMoneyAmount:int)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func addMoney(amount:int):
	playerMoneyAmount += amount
	moneyChanged.emit(playerMoneyAmount)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	


func _on_trip_manager_complete_trip(moneyAmount):
	addMoney(moneyAmount)
