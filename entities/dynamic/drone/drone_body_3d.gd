@icon("./DroneBody3D.png")
extends CharacterBody3D
class_name DroneBody3D

@export_group("Private")
@export var MOVEMENT_COMPONENT: MovementComponent
@export var BATTERY_COMPONENT: BatteryComponent
@export var DEATH_COMPONENT: DeathComponent
@export var HOOK_COMPONENT: HookComponent
@export var SOUND_COMPONENT: SoundComponent

signal charge_change(charge: float)
signal on_death(death_message: String, animated: bool)

func _ready():
	add_to_group("drone")  
	
func start():
	MOVEMENT_COMPONENT.can_move = true;

func _on_battery_component_charge_change(charge: float) -> void:
	charge_change.emit(charge)
	
	if (charge <= 0.0):
		die("You ran out of battery charge!")

func set_windy(value: bool):
	MOVEMENT_COMPONENT.windy = value 
	SOUND_COMPONENT.windy = value
	HOOK_COMPONENT.deattach()
	
func charge_increment(increment: float):
	BATTERY_COMPONENT.charge += increment
	SOUND_COMPONENT.play_charge()

func die(death_message: String, animated = true):
	if (DEATH_COMPONENT.dead):
		return
	DEATH_COMPONENT.kill()
	on_death.emit(death_message, animated)

func _on_delivery_point_spawner_on_delivery() -> void:
	SOUND_COMPONENT.sound_deliver.play()
