@icon("./Charger.png")
extends Node3D

@export var CHARGE_SPEED := 1

var drone: DroneBody3D

func _on_recharge_increment_timer_timeout() -> void:
	if (drone):
		drone.charge_increment(CHARGE_SPEED)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is DroneBody3D:
		drone = body

func _on_area_3d_body_exited(_body: Node3D) -> void:
	drone = null
