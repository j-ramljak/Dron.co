@icon("./Package3D.png")
extends RigidBody3D
class_name Package3D
var is_being_carried = false

@export var max_height = 10
var fall_damage = 0

func chage_carrying_state():
	if is_being_carried:
		fall_damage = global_position.y
	is_being_carried = not is_being_carried

func get_height():
	var points = $CollisionShape3D.shape.points
	var min_y := INF
	var max_y := -INF

	for p in points:
		min_y = min(min_y, p.y)
		max_y = max(max_y, p.y)
		
	return max_y - min_y
	
func destroy():
	queue_free()

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Ground") and fall_damage >= max_height:
		destroy()
