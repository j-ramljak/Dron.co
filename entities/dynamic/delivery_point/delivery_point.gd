extends Area3D

signal package_delivered(value:int)

func _on_body_entered(body: Node3D) -> void:
	if body is Package3D and not body.is_being_carried:
		emit_signal("package_delivered", 1)
		body.deliver()
