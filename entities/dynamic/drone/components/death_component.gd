@icon("./DeathComponent.png")
extends Node
class_name DeathComponent

@export var MOVEMENT_COMPONENT: MovementComponent
var dead = false;

func kill():
	dead = true;
	MOVEMENT_COMPONENT.can_move = false;
	$"../Model/AnimationPlayer".stop()
	# implementirati šta se dogodi kada je game over...
