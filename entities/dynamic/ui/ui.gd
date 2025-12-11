extends Control

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
