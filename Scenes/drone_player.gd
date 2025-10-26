extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const JOYSTICK_LOOK_SENSITIVITY = 2.0

@onready var head = $Head
@onready var camera = $Head/Camera3D
var acceleration_x=0
var acceleration_y=0
var acceleration_z=0
func _physics_process(delta: float) -> void:

	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta

	# Movement input
	var input_dir := Input.get_vector("go_left", "go_right", "go_front", "go_back")
	
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		acceleration_x= direction.x * SPEED
		acceleration_z= direction.z * SPEED
	else:
		acceleration_x= 0.01
		acceleration_z = 0.0
	var a=sqrt(acceleration_x**2+acceleration_z**2)
	velocity.x += acceleration_x * delta
	velocity.z += acceleration_z * delta
	
	#trenje
	velocity.x*=0.98
	velocity.z*=0.98
	
	var look_input := Input.get_axis("rotate_left", "rotate_right")
	var throttle_input := Input.get_axis("go_up", "go_down")
	
	if abs(look_input) > 0.05:  
		rotate_y(-look_input * JOYSTICK_LOOK_SENSITIVITY * delta)
		
	if abs(throttle_input) > 0.1:  
		velocity.y=-throttle_input*10
		
	move_and_slide()
