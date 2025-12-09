extends Node3D

@export var MOVEMENT_COMPONENT: MovementComponent
@export var CAMERA_SMOOTHNESS = 1.5
@export var MAX_SIDE_ANGLE = PI/6
@export var TILT_STRENGTH = 0.01
@export var MAX_TILT_UP = deg_to_rad(20)
@export var MAX_TILT_DOWN = deg_to_rad(90)

func _process(delta):
	var parent: Node3D = get_parent()
	position = parent.position
	
	# If the camera rotation is too far out to the side, make it faster come to the center
	var y_angle_diff = angle_difference(rotation.y, parent.rotation.y)
	if abs(y_angle_diff) > MAX_SIDE_ANGLE:
		#rotation.y = clamp(rotation.y, parent.rotation.y - MAX_SIDE_ANGLE, parent.rotation.y + MAX_SIDE_ANGLE)
		if y_angle_diff > 0:
			rotation.y = lerp_angle(rotation.y, parent.rotation.y + MAX_SIDE_ANGLE, CAMERA_SMOOTHNESS * delta)
		else:
			rotation.y = lerp_angle(rotation.y, parent.rotation.y - MAX_SIDE_ANGLE, CAMERA_SMOOTHNESS * delta)
		
	else:
		rotation.y = lerp_angle(rotation.y, parent.rotation.y, CAMERA_SMOOTHNESS * delta)

	# If player moves up, rotate camera below him so the player can see better upwards. Same for opposite direction
	var target_pitch = clamp(MOVEMENT_COMPONENT.acceleration.y * TILT_STRENGTH, -MAX_TILT_DOWN, MAX_TILT_UP)
	rotation.x = lerp_angle(rotation.x, target_pitch, CAMERA_SMOOTHNESS * delta)
