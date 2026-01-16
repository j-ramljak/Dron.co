@icon("./game_master.png")
extends Node
class_name GameMaster

signal delivered_changed(delivered: int)
signal time_changed(time: float)

@export var GAME_TIMER: Timer
#@export var DRONE: DroneBody3D
#@export var INTERFACE: UserInterface
#@export var ENVIRONMENT: GameEnvironment
#@export var GAME_AREA: PlayerArea3D
#@export var SIGNAL_AREA: PlayerArea3D
#@export var WIND_AREA: PlayerArea3D

var packages_delivered := 0:
	set(value):
		delivered_changed.emit(value)
		packages_delivered = value
		
func _process(_delta: float) -> void:
	time_changed.emit(GAME_TIMER.time_left)

func _input(_event):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

func deliver():
	packages_delivered += 1
