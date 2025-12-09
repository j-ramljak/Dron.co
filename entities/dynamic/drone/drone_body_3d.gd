@icon("./DroneBody3D.png")
extends CharacterBody3D
class_name DroneBody3D

@export var BATTERY_COMPONENT : BatteryComponent

signal charge_change(charge: float)

func _on_battery_component_charge_change(charge: float) -> void:
	charge_change.emit(charge)

func charge_increment(increment: float):
	BATTERY_COMPONENT.charge += increment	
