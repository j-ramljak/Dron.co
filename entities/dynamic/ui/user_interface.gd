@icon("./UserInterface.png")
extends Control
class_name UserInterface

signal graphics_high()
signal graphics_low()

@export_group("Private")
@export var HUD: Control
@export var MAIN_MENU: Control
@export var GAME_OVER: Control
@export var CHARGE_DISPLAY: Label

func _ready() -> void:
	MAIN_MENU.visible = true
	HUD.visible = false
	GAME_OVER.visible = false

func update_charge(charge: float):
	CHARGE_DISPLAY.text = str(charge)

func close_main_menu():
	MAIN_MENU.visible = false
	HUD.visible = true

func close_game_over():
	GAME_OVER.visible = false

func quit():
	get_tree().quit()

func set_graphics(value):
	if !value:
		graphics_high.emit()
	else:
		graphics_low.emit()
