extends "res://Scripts/BaseDoubleFeatureManipulation.gd"

func _ready() -> void:
	var decals = head.find_child("Decals", true)
	feature_left = decals.find_child("LeftBrow", true)
	original_feature_left_position = feature_left.position
	original_feature_left_scale = feature_left.scale
	original_feature_left_rotation = feature_left.rotation
	feature_right = decals.find_child("RightBrow", true)
	original_feature_right_position = feature_right.position
	original_feature_right_scale = feature_right.scale
	original_feature_right_rotation = feature_right.rotation
	
	feature_options = $Options
	set_slider_properties($Options/Height/HeightSlider,  0.5, -1, 0) 
	set_slider_properties($Options/Distance/PositionSlider,  0.5, -0.5, 0)
	set_slider_properties($Options/Size/SizeSlider,  1, -0.5, 0)
	set_slider_properties($Options/Squash/SquashSlider,  2, -0.5, 0)
	set_slider_properties($Options/Stretch/StretchSlider,  2, -0.5, 0)
