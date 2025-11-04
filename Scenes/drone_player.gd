extends CharacterBody3D

@export var SPEED = 50.0
@export var JOYSTICK_LOOK_SENSITIVITY = 2.0
@export var FRICTION = 0.9
@export var TILT_STRENGTH = 0.2
@export var TILT_SMOOTHNESS = 4.0

var acceleration := Vector3.ZERO

func _physics_process(delta: float) -> void:
	
	# Movement
	var input_dir := Input.get_vector("go_left", "go_right", "go_front", "go_back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction != Vector3.ZERO:
		acceleration.x = direction.x * SPEED
		acceleration.z = direction.z * SPEED
	else:
		acceleration.x = 0.0
		acceleration.z = 0.0

	# Rotation (yaw)
	var look_input := Input.get_axis("rotate_left", "rotate_right")
	if abs(look_input) > 0.05:
		rotate_y(-look_input * JOYSTICK_LOOK_SENSITIVITY * delta)

	# Throttle (up/down)
	var throttle_input := Input.get_axis("go_up", "go_down")
	if abs(throttle_input) > 0.05:
		acceleration.y = -throttle_input * SPEED
	else:
		acceleration.y = 0.0
	
	# Velocity
	velocity += acceleration * delta
	velocity *= FRICTION
	
	# Hover effect
	position.y += sin(Time.get_ticks_msec() / 500.0) / 1000.0

	move_and_slide()

	# Rotation effect
	if direction != Vector3.ZERO:
		var local_dir := global_transform.basis.inverse() * direction
		var target_rot_x = local_dir.z * TILT_STRENGTH
		var target_rot_z = -local_dir.x * TILT_STRENGTH

		rotation.x = lerp(rotation.x, target_rot_x, TILT_SMOOTHNESS * delta)
		rotation.z = lerp(rotation.z, target_rot_z, TILT_SMOOTHNESS * delta)
	else:
		rotation.x = lerp(rotation.x, 0.0, TILT_SMOOTHNESS * delta)
		rotation.z = lerp(rotation.z, 0.0, TILT_SMOOTHNESS * delta)
