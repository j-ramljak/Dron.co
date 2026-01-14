@icon("./UserInterface.png")
extends Control
class_name UserInterface

signal graphics_high()
signal graphics_low()
signal on_timeout()
enum Menu { MAIN_MENU, HUD, GAME_OVER }
var delivered_pacakges := 0

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
@export var GLOBAL_TIMER: Timer
@export var STATIC_OVERLAY: Control
@export var YOU_DIED_ANIMATION: AnimationPlayer

func _ready() -> void:
	goto_menu(START_AT)
	
func _process(_delta: float) -> void:
	GLOBAL_TIMER_LABEL.text  = "%02d:%02d" % time_left_global()
	
func time_left_global():
	var time_left = GLOBAL_TIMER.time_left
	var minute = floor(time_left / 60)
	var second = int(time_left) % 60
	return [minute, second]

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
	GLOBAL_TIMER.start()
	
func death_animation_finish():
	goto_menu(Menu.GAME_OVER)
	
func global_timer_finish():
	on_timeout.emit()

# Za spojiti sa signalima 􏿿􏿿↓

func update_charge(charge: float):
	CHARGE_LABEL.text = str(charge)
	
func update_delivery_count(value: int):
	delivered_pacakges += value
	DELIVERY_LABEL.text = str(delivered_pacakges)
	TOTAL_DELIVERED_LABEL.text = str(delivered_pacakges)

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
	
func set_battery_warning(value: bool) -> void:
	BATTERY_WARNING.visible = value;
