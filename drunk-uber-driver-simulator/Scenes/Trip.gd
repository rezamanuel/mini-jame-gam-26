extends Node

@export var POIListParent:Node 
@export var PassangerPrefab:Node3D
@export var DestinationPrefab:Node3D
@export var CelebratingPrefab:Node3D
var POIList:Array[Node] = []
var curTripOrigin:Node3D
var curTripDestination:Node3D
var rng = RandomNumberGenerator.new()
var tripMoneyAmount = 0
@export var moneyModifier = 4

var isPassangerPickedUp = false

signal completeTrip(moneyAmount:int)
signal beginTrip()
func getOriginDestinationPair():
	var i:int= rng.randi_range(0,POIList.size()-1)
	curTripOrigin = POIList[i]
	POIList.remove_at(i)
	curTripDestination = POIList[rng.randi_range(0,POIList.size()-1)]
	POIList = POIListParent.get_children()
	tripMoneyAmount = moneyModifier*(curTripDestination.position-curTripOrigin.position).length()
	PassangerPrefab.position = curTripOrigin.position
	DestinationPrefab.position = curTripDestination.position
	isPassangerPickedUp = false

# Called when the node enters the scene tree for the first time.
func _ready():
	POIList = POIListParent.get_children()
	getOriginDestinationPair()
	print(curTripOrigin)
	print(curTripDestination)
	print(tripMoneyAmount)
	DestinationPrefab.set_process(false)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_passanger_passanger_pickup():
	if(!isPassangerPickedUp):
		isPassangerPickedUp = true
	

func _on_destination_reached_destination():
	if(isPassangerPickedUp):
		CelebratingPrefab.position = curTripDestination.position
		completeTrip.emit(tripMoneyAmount)
		getOriginDestinationPair()
