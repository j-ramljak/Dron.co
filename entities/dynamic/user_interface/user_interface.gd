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

@onready var global_timer = $"HUD/TopBar/MarginContainer/HBoxContainer/TimeDisplay/Global timer" 
@onready var global_timer_label = $HUD/TopBar/MarginContainer/HBoxContainer/TimeDisplay/MarginContainer/BoxContainer/TimeValue

func _ready() -> void:
	goto_menu(START_AT)
	

	
func _process(_delta: float) -> void:
	global_timer_label.text  = "%02d:%02d" % time_left_global()

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
	delivery_label.text = str(delivered_pacakges)
	
func time_left_global():
	var time_left = global_timer.time_left
	var minute = floor(time_left / 60)
	var second = int(time_left) % 60
	return [minute, second]

func _on_global_timer_timeout() -> void:
	demo_die()


func _on_start_button_pressed() -> void:
	goto_menu(Menu.HUD)
	global_timer.start()
