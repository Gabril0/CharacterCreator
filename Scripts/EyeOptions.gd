extends "res://Scripts/BaseDoubleFeatureManipulation.gd"

var pupil_list = []

func _ready():
	var decals = head.find_child("Decals", true)
	feature_left = decals.find_child("LeftEye", true)
	original_feature_left_position = feature_left.position
	original_feature_left_scale = feature_left.scale
	original_feature_left_rotation = feature_left.rotation
	feature_right = decals.find_child("RightEye", true)
	original_feature_right_position = feature_right.position
	original_feature_right_scale = feature_right.scale
	original_feature_right_rotation = feature_right.rotation
	
	feature_options = $EyeOptions
	
	set_slider_properties($EyeOptions/EyeDistance/HSlider,  0.15, -0.5, 0) 
	set_slider_properties($EyeOptions/EyeSize/EyeSize, 0.5, -0.5, 0) 
	
	file_search()

func file_search():
	var eyes_path = "res://3DModels/Eyes/"
	var dir = DirAccess.open(eyes_path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.begins_with("eye_") and file_name.ends_with(".png"):
				item_list.append(file_name)
			if file_name.begins_with("pupil_") and file_name.ends_with(".png"):
				pupil_list.append(file_name)
			file_name = dir.get_next()
		dir.list_dir_end()
		feature_left.texture_albedo = load("res://3DModels/Eyes/eye_1.png")
		var eye_list = $EyeOptions/EyeList
		
		for i in range(item_list.size()):
			var bg = load(eyes_path + item_list[i]) #getting the images
			var pupil = load(eyes_path + pupil_list[i])
			var blended_texture
			if bg is Texture and pupil is Texture:
				var bg_image = bg.get_image()
				var pupil_image = pupil.get_image()
				if bg_image.is_compressed() or pupil_image.is_compressed():
					bg_image.decompress()
					pupil_image.decompress()
				blended_texture = bg_image
				
				for x in range(bg_image.get_width()):
					for y in range(bg_image.get_height()):
						var pupil_color = pupil_image.get_pixel(x, y)
						if pupil_color.a != 0 && bg_image.get_pixel(x, y) != pupil_color: # changing each that`s different
							blended_texture.set_pixel(x, y, pupil_color)
							
			var temp_save_path = "temp_eye" + str(i) + ".png"
			blended_texture.save_png(temp_save_path)
			var new_texture = load("res://" + temp_save_path)#maybe optimize later, for some reason it doesn`t let me just use or compress this image into
			#the right format, so i need to save and then delete it
			dir.remove("res://" + temp_save_path) #change this to make it run, probably is deleting before the access
			eye_list.add_icon_item(new_texture)

func _on_item_list_item_selected(index: int) -> void:
	var eyes_path = "res://3DModels/Eyes/"
	feature_left.texture_albedo = load(eyes_path + pupil_list[index])
	feature_right.texture_albedo = load(eyes_path + pupil_list[index])
	feature_left.get_child(0).texture_albedo = load(eyes_path + item_list[index])
	feature_right.get_child(0).texture_albedo = load(eyes_path + item_list[index])
	

