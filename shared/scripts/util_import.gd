@tool
extends EditorScenePostImport

const MATERIALS := {
	"palette_color" = preload("res://shared/materials/palette_color.tres"),
	"palette_foliage" = preload("res://shared/materials/palette_foliage.tres")
}
	
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
				set_material(child)

func set_children_owner(node, owner):
	for n in node.get_children():
		n.owner = owner
		set_children_owner(n, owner)

func set_material(node: MeshInstance3D):
	for index in range(node.mesh.get_surface_count()):
		for key in MATERIALS.keys():
			var name = node.mesh.surface_get_material(index).resource_name
			if key == name and MATERIALS.has(name):
				node.mesh.surface_set_material(index, MATERIALS[key])
			
