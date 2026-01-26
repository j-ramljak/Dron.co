extends Node3D



func _process(delta: float) -> void:

	var delivery_points = get_tree().get_nodes_in_group("delivery_point")
	if delivery_points.size() > 0:
		var delivery_point = delivery_points[0]
		look_at(delivery_point.global_transform.origin, Vector3.UP)
		

	
