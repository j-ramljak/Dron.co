extends Area3D

signal out_of_bounds
signal on_exit
signal on_enter

func player_entered_or_exited(body: Node3D) -> void:
	if body is DroneBody3D:
		emit_signal("out_of_bounds")

func player_enter(body: Node3D) -> void:
	if (body is DroneBody3D):
		on_enter.emit()
	
func player_exit(body: Node3D) -> void:
	if (body is DroneBody3D):
		on_exit.emit()
