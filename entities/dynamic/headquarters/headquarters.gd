@icon("./Headquarters.png")
extends Node3D
class_name Headquarters

signal spawned_package()
@onready var HIGHLIGHT_MESH: MeshInstance3D = $Model/headquarters_highlight
@onready var MARKER = $PackageSpawnPoint
@onready var TIMER = $Timer
@onready var package_scenes = [
	preload("res://entities/dynamic/package/box_small.tscn"),
	preload("res://entities/dynamic/package/box_large.tscn"), 
	preload("res://entities/dynamic/package/box_medium.tscn"),
	preload("res://entities/dynamic/package/crate_large.tscn"), 
	preload("res://entities/dynamic/package/crate_medium.tscn"),
	preload("res://entities/dynamic/package/crate_small.tscn")
]

var has_package = false
var delivery_in_progress = false

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Package3D:
		HIGHLIGHT_MESH.visible = true
		has_package = true
		delivery_in_progress = false

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body is Package3D:
		HIGHLIGHT_MESH.visible = false
		has_package = false
		delivery_in_progress = true
		TIMER.start()

func _on_timer_timeout() -> void:
	if not has_package and not delivery_in_progress:
		var package_instance = package_scenes[randi_range(0,package_scenes.size())-1].instantiate()
		add_child(package_instance)
		package_instance.global_position = MARKER.global_position
		has_package = true
		spawned_package.emit()
		
func delivery_state_toggle():
	delivery_in_progress = not delivery_in_progress
