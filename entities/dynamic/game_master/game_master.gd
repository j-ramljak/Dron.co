@icon("./game_master.png")
extends Node
class_name GameMaster

signal delivered_changed(delivered: int)
signal time_changed(time: float)

@export var GAME_TIMER: Timer
@export var TIME_ADD_ON_DELIVERY := 15.0

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
	GAME_TIMER.start(GAME_TIMER.time_left + TIME_ADD_ON_DELIVERY)
