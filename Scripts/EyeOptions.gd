extends "res://Scripts/BaseDoubleFeatureManipulation.gd"

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
