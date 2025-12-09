@icon("./BatteryComponent.png")
extends Node
class_name BatteryComponent

@export var MAX_CHARGE := 100.0
@export var deplete_speed := 1.0

signal charge_change(charge: float)
signal charge_depleted()
var depleted = false

var charge: float:
	set(value):
		value = clamp(value, 0.0, MAX_CHARGE)
		if (value != charge):
			charge_change.emit(value)
		if (value == 0.0 and !depleted):
			charge_depleted.emit()
			depleted = true
		charge = value

func _ready() -> void:
	charge = MAX_CHARGE

func decrement_charge():
	charge -= deplete_speed
	
func increment_charge(recharge_speed: float):
	charge += recharge_speed
