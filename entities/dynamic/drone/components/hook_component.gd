@icon("./HookComponent.png")
extends Node
class_name HookComponent

@export var MARKER: Node3D
@export var JOINT: Generic6DOFJoint3D

@onready var drone_collison_shape = $"../CollisionShape3D"

signal hook_attach(body: RigidBody3D)
signal hook_deattach()

func _input(event):
	if event.is_action_pressed("drop"):
		deattach()

func _on_hook_area_body_entered(body: Node3D) -> void:
	#if body is RigidBody3D and not JOINT.node_b and body.is_in_group("Package"):
	if body is Package3D and not JOINT.node_b: # provjera klase Package3D umjesto grupe Package
		attach(body)
		
func attach(body: RigidBody3D):
		body.global_position = MARKER.global_position
		JOINT.set_node_b(body.get_path())
		hook_attach.emit(body)
		
		body.chage_carrying_state()
		
		drone_collison_shape.shape.size.y = body.get_height() * 4
		body.set_collision_mask_value(2, false)
		
		
		body.linear_damp = 2
		body.angular_damp = 20 
	
func deattach():
	if not JOINT.node_b:
		return
	var body = get_node(JOINT.node_b)
	
	JOINT.set_node_b("")
	hook_deattach.emit()
	
	body.chage_carrying_state()
	
	drone_collison_shape.shape.size.y = 0.5
	body.set_collision_mask_value(2, true)
	body.linear_damp = 0
	body.angular_damp = 0
