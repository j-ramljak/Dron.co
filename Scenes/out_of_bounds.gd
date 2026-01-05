extends Area3D


signal out_of_bounds


func player_entered_or_exited(body: Node3D) -> void:
	if body is DroneBody3D:
		emit_signal("out_of_bounds")
