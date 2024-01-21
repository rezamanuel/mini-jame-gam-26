extends Node

@export var POIListParent:Node 
@export var PassangerPrefab:Node3D
@export var DestinationPrefab:Node3D
@export var CelebratingPrefab:Node3D
var POIList:Array[Node] = []
var curTripOrigin:Node3D
var curTripDestination:Node3D
var rng = RandomNumberGenerator.new()
var tripMoneyAmount:float = 0
@export var moneyModifier = 4
@export var defaultMoneyDecay = .05
var effectiveMoneyDecay = .05

var isPassangerPickedUp = false

signal completeTrip(moneyAmount:int)
signal routeToNode(destinationNode:Node3D)
signal tripMoneyAmountChanged(potentialMoney:int)

func getOriginDestinationPair():
	var i:int= rng.randi_range(0,POIList.size()-1)
	curTripOrigin = POIList[i]
	POIList.remove_at(i)
	curTripDestination = POIList[rng.randi_range(0,POIList.size()-1)]
	POIList = POIListParent.get_children()
	set_money_trip_amount(moneyModifier*(curTripDestination.position-curTripOrigin.position).length())
	PassangerPrefab.position = curTripOrigin.position
	DestinationPrefab.position = curTripDestination.position
	isPassangerPickedUp = false
	routeToNode.emit(curTripOrigin)
	
func add_money_trip_amount(amount:float):
	tripMoneyAmount += amount
	tripMoneyAmountChanged.emit(tripMoneyAmount)
	
func set_money_trip_amount(amount:float):
	tripMoneyAmount = amount
	
	tripMoneyAmountChanged.emit(tripMoneyAmount)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	POIList = POIListParent.get_children()
	getOriginDestinationPair()
	print(curTripOrigin)
	print(curTripDestination)
	print(tripMoneyAmount)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	add_money_trip_amount(-1*(tripMoneyAmount*effectiveMoneyDecay*delta)) 
	# print(-1*tripMoneyAmount*effectiveMoneyDecay*delta)
	if Input.is_action_just_pressed("reset"):
		add_money_trip_amount(-100)


func _on_passanger_passanger_pickup():
	if(!isPassangerPickedUp):
		isPassangerPickedUp = true
		routeToNode.emit(curTripDestination)
	

func _on_destination_reached_destination():
	if(isPassangerPickedUp):
		CelebratingPrefab.position = curTripDestination.position
		completeTrip.emit(tripMoneyAmount)
		getOriginDestinationPair()


func _on_game_drunk(bacPercent):
	effectiveMoneyDecay = defaultMoneyDecay - (defaultMoneyDecay * bacPercent)


func _on_nissan_gtr_crash():
	add_money_trip_amount(-20)
