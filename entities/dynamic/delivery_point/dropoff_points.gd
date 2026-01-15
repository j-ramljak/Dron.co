extends Node3D


@onready var delivery_point_scene = preload("res://entities/dynamic/delivery_point/delivery_point.tscn")
@onready var delivery_points: Node = $"../Delivery points"

@onready var ui = $"../UserInterface"
@onready var gm =  $"../GameMaster"




func random_location():
	var delivery_markers = self.get_children()
	return delivery_markers[randi_range(0, delivery_markers.size() -1)]
	
	
	
func spawn_delivery_point():
	var spawn_marker = random_location()
	
	var delivery_point_instance = delivery_point_scene.instantiate()
	delivery_points.add_child(delivery_point_instance)
	
	delivery_point_instance.global_position = spawn_marker.global_position
	
	delivery_point_instance.package_delivered.connect(gm.increment_delivered)

	
	
