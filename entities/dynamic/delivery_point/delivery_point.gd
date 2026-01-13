extends Area3D

signal package_delivered(value:int)
@onready var confetti = preload("res://entities/dynamic/delivery_point/confetti.tscn")

func _on_body_entered(body: Node3D) -> void:
	if body is Package3D and not body.is_being_carried:
		emit_signal("package_delivered", 1)
		body.deliver()
		
		var confetti_instance = confetti.instantiate()
		get_tree().current_scene.add_child(confetti_instance)
		confetti_instance.global_position = global_position
		confetti_instance.start()
