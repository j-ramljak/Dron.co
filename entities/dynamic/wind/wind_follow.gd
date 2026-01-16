extends Node3D

@export var FOLLOW_NODE: Node3D

func _process(_delta: float) -> void:
	self.global_position.x = FOLLOW_NODE.global_position.x
	self.global_position.z = FOLLOW_NODE.global_position.z
