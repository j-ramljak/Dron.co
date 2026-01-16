@icon("./UserInterface.png")
extends Control
class_name UserInterface

signal graphics_high()
signal graphics_low()
signal on_start()
signal change_saturation(saturation: float)
enum Menu { MAIN_MENU, HUD, GAME_OVER }

@export var START_AT := Menu.MAIN_MENU
@export_group("Private")
@export_subgroup("Menus")
@export var HUD: Control
@export var MAIN_MENU: Control
@export var GAME_OVER: Control
@export_subgroup("Labels")
@export var CHARGE_LABEL: Label
@export var DELIVERY_LABEL: Label
@export var GLOBAL_TIMER_LABEL: Label
@export var DEATH_MESSAGE_LABEL: Label
@export var TOTAL_DELIVERED_LABEL: Label
@export_subgroup("Warnings")
@export var SIGNAL_WARNING: Control
@export var BATTERY_WARNING: Control
@export var WIND_WARNING: Control
@export_subgroup("Other")
@export var STATIC_OVERLAY: Control
@export var YOU_DIED_ANIMATION: AnimationPlayer
@export var CONTROLS_MENU: Control

func _ready() -> void:
	goto_menu(START_AT)
	TOTAL_DELIVERED_LABEL.text = str(0)
	
func quit():
	get_tree().quit()
	
func reset() -> void:
	get_tree().reload_current_scene()

func goto_menu(menu: Menu):
	MAIN_MENU.visible = false
	HUD.visible = false
	GAME_OVER.visible = false
	match menu:
		Menu.MAIN_MENU:
			MAIN_MENU.visible = true
		Menu.HUD:
			HUD.visible = true
		Menu.GAME_OVER:
			GAME_OVER.visible = true

func set_graphics(value):
	if !value:
		graphics_high.emit()
	else:
		graphics_low.emit()

func _on_start_button_pressed() -> void:
	goto_menu(Menu.HUD)
	on_start.emit()
	
func death_animation_finish():
	goto_menu(Menu.GAME_OVER)
	
# Za spojiti sa signalima 􏿿􏿿↓

func set_charge(charge: float):
	CHARGE_LABEL.text = String.num(charge, 1)
	change_saturation.emit(clamp(charge / 25.0, 0.0, 1.0))
	if (charge < 25.0):
		BATTERY_WARNING.visible = true;
	else:
		BATTERY_WARNING.visible = false;
	
func set_delivered(value: int):
	DELIVERY_LABEL.text = str(value)
	TOTAL_DELIVERED_LABEL.text = str(value)

func set_countdown(seconds: float) -> void:
	var minute = floor(seconds / 60)
	var second = int(seconds) % 60
	GLOBAL_TIMER_LABEL.text  = "%02d:%02d" % [minute, second]

func set_death_screen(death_message:= "You died", animated := true):
	DEATH_MESSAGE_LABEL.text = death_message
	if (animated):
		YOU_DIED_ANIMATION.play("you_died")
	else:
		goto_menu(Menu.GAME_OVER)
	
func set_signal_warning(value: bool) -> void:
	SIGNAL_WARNING.visible = value
	STATIC_OVERLAY.visible = value;
	
func set_wind_warning(value: bool) -> void:
	WIND_WARNING.visible = value;
	
func set_controls(value: bool) -> void:
	CONTROLS_MENU.visible = value;
