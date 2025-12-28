extends PanelContainer

@export var text := "Warning text!"

func _ready() -> void:
	$MarginContainer/VBoxContainer/HBoxContainer/LabelText.text = text
