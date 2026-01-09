@icon("./GameEnvironment.png")
extends Node3D
class_name GameEnvironment

@onready var SUN: DirectionalLight3D = $DirectionalLight3D
@onready var ENVIRONMENT: WorldEnvironment = $WorldEnvironment
@onready var OUTLINE: MeshInstance3D = $OutlineEffect
@onready var WATER: MeshInstance3D = $Water

func set_graphics_low():
	OUTLINE.visible = false
	ENVIRONMENT.environment.ssao_enabled = false
	SUN.directional_shadow_mode = DirectionalLight3D.ShadowMode.SHADOW_ORTHOGONAL
	WATER.mesh.material.set_shader_parameter("ssr_enabled", false)
	
func set_graphics_high():
	OUTLINE.visible = true
	ENVIRONMENT.environment.ssao_enabled = true
	SUN.directional_shadow_mode = DirectionalLight3D.ShadowMode.SHADOW_PARALLEL_4_SPLITS
	WATER.mesh.material.set_shader_parameter("ssr_enabled", true)
