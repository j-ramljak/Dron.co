extends Node3D

@export var DRONE: DroneBody3D

func _process(_delta: float) -> void:
	self.global_position.x = DRONE.global_position.x
	self.global_position.z = DRONE.global_position.z
