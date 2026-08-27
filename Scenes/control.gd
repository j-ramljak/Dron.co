extends Control

@export var generator: Node3D

const PARAMS = [
	["City size", "city_size", 4, 40, 1],
	["Road branching", "road_branching", 1, 4, 1],
	["Building density", "building_density", 0.0, 1.0, 0.05],
	["Park probability", "park_probability", 0.0, 1.0, 0.05],
	["Tree density", "tree_density", 0.0, 1.0, 0.05],
]

var labels := {}
var seed_box: SpinBox
var random_box: CheckBox
var status: Label

func _ready() -> void:
	var panel := PanelContainer.new()
	panel.position = Vector2(20, 20)
	panel.custom_minimum_size = Vector2(300, 0)
	add_child(panel)

	var column := VBoxContainer.new()
	panel.add_child(column)

	var title := Label.new()
	title.text = "City settings"
	column.add_child(title)

	random_box = CheckBox.new()
	random_box.text = "Random seed"
	random_box.button_pressed = true
	random_box.toggled.connect(on_random_toggled)
	column.add_child(random_box)

	seed_box = SpinBox.new()
	seed_box.max_value = 999999
	seed_box.editable = false
	column.add_child(seed_box)

	for p in PARAMS:
		var property_name: String = p[1]
		var whole: bool = p[4] >= 1

		var label := Label.new()
		label.text = p[0]
		column.add_child(label)
		labels[property_name] = label

		var slider := HSlider.new()
		slider.min_value = p[2]
		slider.max_value = p[3]
		slider.step = p[4]
		if generator != null:
			slider.value = generator.get(property_name)
		slider.value_changed.connect(func(v): on_changed(property_name, v, whole))
		column.add_child(slider)

		show_value(property_name, slider.value, whole)

	var button := Button.new()
	button.text = "Generate"
	button.pressed.connect(generate)
	column.add_child(button)

	status = Label.new()
	column.add_child(status)

func show_value(property_name: String, value: float, whole: bool) -> void:
	var label: Label = labels[property_name]
	var text := str(int(value)) if whole else "%.2f" % value
	label.text = label.text.split(":")[0] + ": " + text

func on_changed(property_name: String, value: float, whole: bool) -> void:
	if generator != null:
		generator.set(property_name, int(value) if whole else value)
	show_value(property_name, value, whole)

func on_random_toggled(pressed: bool) -> void:
	seed_box.editable = not pressed
	if generator != null:
		generator.random_seed = pressed

func generate() -> void:
	if generator == null:
		status.text = "No generator assigned."
		return
	if not random_box.button_pressed:
		generator.seed_value = int(seed_box.value)
	generator.random_seed = random_box.button_pressed
	generator.build()
	seed_box.set_value_no_signal(generator.seed_value)
	status.text = "Seed " + str(generator.seed_value)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		visible = not visible
