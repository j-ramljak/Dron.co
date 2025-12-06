@tool
extends EditorScenePostImport

const MATERIAL = preload("res://shared/materials/palette_color.tres")

func _post_import(scene):
	iterate(scene)
	if scene.get_child_count(true) == 1:
		var single_node = scene.get_child(0)
		scene.remove_child(single_node)
		single_node.owner = null
		set_children_owner(single_node, single_node)
		return single_node
	else:
		return scene
	
func iterate(node: Node):
	if node != null:
		for child in node.get_children():
			iterate(child)
			if child is MeshInstance3D:
				child.mesh.surface_set_material(0, MATERIAL)

func set_children_owner(node, owner):
	for n in node.get_children():
		n.owner = owner
		set_children_owner(n, owner)
