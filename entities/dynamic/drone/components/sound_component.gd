extends Node
class_name SoundComponent

@export var DRONE: DroneBody3D
@export var windy: bool = false

@onready var sound_windy = $SoundWindy
@onready var sound_charge = $SoundCharge
@onready var sound_attach = $SoundAttach
@onready var sound_detach = $SoundDetach
@onready var sound_deliver = $SoundDeliver
@onready var sound_propeller = $SoundPropeller

var last_played_charge_sound = 0

func _physics_process(_delta: float) -> void:
	var propeller_pitch = lerpf(1.0, 4.0, DRONE.velocity.length() / 50.0)
	sound_propeller.pitch_scale = propeller_pitch

func _process(delta: float) -> void:
	var current_volume = sound_windy.get_volume_db()
	var next_volume: float
	
	if windy:
		next_volume = minf(current_volume + 50.0 * delta, 0.0)
	else:
		next_volume = maxf(current_volume - 50.0 * delta, -50.0)
		
	sound_windy.set_volume_db(next_volume)
	
	if Time.get_ticks_msec() - last_played_charge_sound > 200:
		sound_charge.stop()
	
func play_charge() -> void:
	last_played_charge_sound = Time.get_ticks_msec()
	
	if !sound_charge.playing:
		sound_charge.play()

func _on_hook_component_hook_attach(_body: RigidBody3D) -> void:
	sound_attach.play()

func _on_hook_component_hook_deattach() -> void:
	sound_detach.play()
