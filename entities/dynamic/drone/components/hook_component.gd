@icon("./HookComponent.png")
extends Node
class_name HookComponent

@export var MARKER: Node3D
@export var JOINT: Generic6DOFJoint3D

signal hook_attach(body: RigidBody3D)
signal hook_deattach()

func _input(event):
	if event.is_action_pressed("drop"):
		deattach()

func _on_hook_area_body_entered(body: Node3D) -> void:
	if body is RigidBody3D and not JOINT.node_b and body.is_in_group("Package"):
		attach(body)
		
func attach(body: RigidBody3D):
		body.global_position = MARKER.global_position
		JOINT.set_node_b(body.get_path())
		hook_attach.emit(body)
	
func deattach():
	if not JOINT.node_b:
		return
	JOINT.set_node_b("")
	hook_deattach.emit()
