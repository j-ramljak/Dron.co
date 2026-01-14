extends Node3D
@onready var wind=$WindParticles
@onready var drone=$DroneBody3D
@onready var windArea=$Areas/WindArea

func _physics_process(_delta: float) -> void:
	wind.position=drone.position-Vector3(15,0,0)
	if is_drone_in_wind_area():
		wind.emitting = true
	else:
		wind.emitting = false
		
func is_drone_in_wind_area() -> bool:
	var overlapping_bodies = windArea.get_overlapping_bodies()
	for body in overlapping_bodies:
		if body == drone:
			return true
	return false

func _input(_event):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
