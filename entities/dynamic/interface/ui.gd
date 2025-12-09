extends Control

@export var CHARGE_DISPLAY: Label

func update_charge(charge: float):
	CHARGE_DISPLAY.text = str(charge)
