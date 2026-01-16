@icon("./DeathComponent.png")
extends Node
class_name DeathComponent

@export var MOVEMENT_COMPONENT: MovementComponent
var dead = false;

func kill():
	dead = true;
	MOVEMENT_COMPONENT.SPEED = 0.0;
	MOVEMENT_COMPONENT.ROTATE_SENSITIVITY = 0.0;
	MOVEMENT_COMPONENT.TILT_STRENGTH = 0.0;
	$"../Model/AnimationPlayer".stop()
	# implementirati šta se dogodi kada je game over...
