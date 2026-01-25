@icon("./player_area_3d.png")
extends Area3D
class_name PlayerArea3D

signal on_player_entered
signal on_player_exited
signal on_package_exited

func player_entered(body: Node3D) -> void:
	if (body is DroneBody3D):
		on_player_entered.emit()

	
		

	
func player_exited(body: Node3D) -> void:
	print(1)
	if (body is DroneBody3D):
		on_player_exited.emit()
	if body is Package3D:
		on_package_exited.emit()
