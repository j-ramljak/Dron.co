@icon("./UserInterface.png")
extends Control
class_name UserInterface

signal graphics_high()
signal graphics_low()
enum Menu { MAIN_MENU, HUD, GAME_OVER }

@export var START_AT := Menu.MAIN_MENU

@export_group("Private")
@export var HUD: Control
@export var MAIN_MENU: Control
@export var GAME_OVER: Control
@export var CHARGE_DISPLAY: Label



@onready var delivery_label = $HUD/TopBar/MarginContainer/HBoxContainer/DeliveryDisplay/MarginContainer/BoxContainer/DeliveryValue
var delivered_pacakges: int = 0

func _ready() -> void:
	goto_menu(START_AT)

func quit():
	get_tree().quit()

func goto_menu(menu: Menu):
	match menu:
		Menu.MAIN_MENU:
			MAIN_MENU.visible = true
			HUD.visible = false
			GAME_OVER.visible = false
		Menu.HUD:
			MAIN_MENU.visible = false
			HUD.visible = true
			GAME_OVER.visible = false
		Menu.GAME_OVER:
			MAIN_MENU.visible = false
			HUD.visible = false
			GAME_OVER.visible = true

func set_graphics(value):
	if !value:
		graphics_high.emit()
	else:
		graphics_low.emit()

func update_charge(charge: float):
	CHARGE_DISPLAY.text = str(charge)

func demo_die():
	$YouDied/AnimationPlayer.play("you_died")

func demo_died():
	goto_menu(Menu.GAME_OVER)

func update_delivery_count(value: int):
	#potrebno u editoru ih connectat
	delivered_pacakges += value
	print(delivered_pacakges)
	delivery_label.text = str(delivered_pacakges)
	
