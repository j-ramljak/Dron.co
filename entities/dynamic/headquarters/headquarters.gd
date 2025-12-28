@icon("./Headquarters.png")
extends Node3D

@onready var HIGHLIGHT_MESH: MeshInstance3D = $Model/headquarters_highlight

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Package3D:
		HIGHLIGHT_MESH.visible = true

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body is Package3D:
		HIGHLIGHT_MESH.visible = false
