@icon("./DeathComponent.png")
extends Node
class_name DeathComponent

var dead = false;

func kill():
	dead = true;
	print("drone is kil")
	# implementirati šta se dogodi kada je game over...
