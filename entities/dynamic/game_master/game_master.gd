@icon("./game_master.pngp")
extends Node
class_name GameMaster

signal on_timeout()
signal delivered_changed(delivered: int)
signal time_changed(time: float)
var packages_delivered := 0:
	set(value):
		delivered_changed.emit(value)
		packages_delivered = value

func _process(_delta: float) -> void:
	time_changed.emit($GameDurationTimer.time_left)

func game_timer_finish():
	on_timeout.emit()
