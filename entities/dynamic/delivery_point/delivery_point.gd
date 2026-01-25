@icon("./delivery_point.png")
extends Area3D
class_name DeliveryPoint3D

signal on_delivery()
@onready var CONFETTI = preload("res://entities/dynamic/delivery_point/CONFETTI.tscn")
@onready var RING := $delivery_point_model/delivery_point_ring
var tween : Tween

func _ready() -> void:
	print(1)
	tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD).set_loops()
	tween.tween_property(RING, "scale", Vector3(1.2, 1.2, 1.2), 0.5)
	tween.chain().tween_property(RING, "scale", Vector3(1.0, 1.0, 1.0), 0.5)

func _on_body_entered(body: Node3D) -> void:
	if body is Package3D and not body.is_being_carried:
		on_delivery.emit()
		body.destroy()
		
		var confetti_instance = CONFETTI.instantiate()
		get_tree().current_scene.add_child(confetti_instance)
		confetti_instance.global_position = global_position
		confetti_instance.start()
		
		await get_tree().create_timer(1.0).timeout
		tween.kill()
		queue_free()
