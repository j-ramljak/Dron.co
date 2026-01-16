extends Node3D

@onready var DELIVERY_POINT_SCENE = preload("res://entities/dynamic/delivery_point/delivery_point.tscn")
@export var GAME_MASTER: GameMaster
@export var HEADQUARTERS: Headquarters

func random_location():
	var delivery_markers = self.get_children()
	return delivery_markers[randi_range(0, delivery_markers.size() -1)]
	
func spawn_delivery_point():
	var spawn_marker = random_location()
	
	var delivery_point_instance = DELIVERY_POINT_SCENE.instantiate()
	get_tree().root.add_child(delivery_point_instance)

	delivery_point_instance.global_position = spawn_marker.global_position
	delivery_point_instance.on_delivery.connect(GAME_MASTER.deliver)
	delivery_point_instance.on_delivery.connect(HEADQUARTERS.delivery_state_toggle)
