@icon("./Package3D.png")
extends RigidBody3D
class_name Package3D
var is_being_carried = false

func chage_carrying_state():
	is_being_carried = not is_being_carried

func get_height():
	var points = $CollisionShape3D.shape.points
	var min_y := INF
	var max_y := -INF

	for p in points:
		min_y = min(min_y, p.y)
		max_y = max(max_y, p.y)
		
	return max_y - min_y
	
	
func deliver():
	queue_free()
