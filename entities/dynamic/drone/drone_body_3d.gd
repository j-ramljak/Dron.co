@icon("./DroneBody3D.png")
extends CharacterBody3D
class_name DroneBody3D

@export_group("Private")
@export var MOVEMENT_COMPONENT: MovementComponent
@export var BATTERY_COMPONENT: BatteryComponent
@export var DEATH_COMPONENT: DeathComponent

signal charge_change(charge: float)
signal on_death(death_message: String)

func _ready():
	add_to_group("drone")  

func _on_battery_component_charge_change(charge: float) -> void:
	charge_change.emit(charge)
	if (charge <= 0.0):
		die("You ran out of battery charge!")

func set_windy(value: bool):
	MOVEMENT_COMPONENT.windy = value 
	
func charge_increment(increment: float):
	BATTERY_COMPONENT.charge += increment	

func die(death_message: String):
	DEATH_COMPONENT.kill()
	on_death.emit(death_message)
