extends "res://Scripts/BaseSingleFeatureManipulation.gd"

var mesh : MeshInstance3D
var hair_list = []

func _ready() -> void:
	var models = head.find_child("3dModel", true)
	feature = models.find_child("Hair", true)
	original_feature_position = feature.position
	mesh = feature
	find_hair_list()

func _on_color_picker_button_color_changed(color: Color) -> void:
	var hair_material : Material = mesh.get_active_material(0)
	hair_material.albedo_color = color

func _on_options_item_selected(index: int) -> void:
	var new_hair_scene = load("res://3DModels/Hair/" + hair_list[index])
	
	if new_hair_scene:
		var new_hair = new_hair_scene.instantiate()
		new_hair.position = original_feature_position + new_hair.position
		var new_hair_material : Material = new_hair.get_active_material(0)
		new_hair_material.albedo_color = mesh.get_active_material(0).albedo_color
		
		var models = head.find_child("3dModel", true)
		models.remove_child(feature)
		feature.queue_free()
		
		var parent = models
		parent.add_child(new_hair)
		new_hair.name = "Hair"
		feature = new_hair
		mesh = feature
		
func find_hair_list():
	var path = "res://3DModels/Hair/"
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.begins_with("hair_") and file_name.ends_with(".tscn"):
				hair_list.append(file_name)
			file_name = dir.get_next()
		dir.list_dir_end()

