extends "res://Scripts/BaseSingleFeatureManipulation.gd"

func _ready() -> void:
	var decals = head.find_child("Decals", true)
	feature = decals.find_child("Nose", true)
	original_feature_position = feature.position
	original_feature_scale = feature.scale
	original_feature_rotation = feature.rotation
	
	feature_options = $Options
	set_slider_properties($Options/Height/HeightSlider,  1, -0.4, 0) 
	set_slider_properties($Options/Distance/PositionSlider,  0.5, -0.5, 0) 
	set_slider_properties($Options/Size/SizeSlider,  1, -0.5, 0)
	set_slider_properties($Options/Squash/SquashSlider,  2, -0.5, 0)
	set_slider_properties($Options/Stretch/StretchSlider,  2, -0.5, 0)
