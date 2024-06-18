extends "res://Scripts/BaseSingleFeatureManipulation.gd"

func _ready() -> void:
	var decals = head.find_child("Decals", true)
	feature = decals.find_child("Mouth", true)
	original_feature_position = feature.position
	original_feature_scale = feature.scale
	original_feature_rotation = feature.rotation
	
	feature_options = $MouthOptions
	set_slider_properties($MouthOptions/MouthHeight/HeightSlider,  1, -0.4, 0) 
	set_slider_properties($MouthOptions/MouthDistance/PositionSlider,  0.5, -0.5, 0) 
	set_slider_properties($MouthOptions/MouthSize/SizeSlider,  1, -0.5, 0)
	set_slider_properties($MouthOptions/MouthSize/SizeSlider,  1, -0.5, 0)
	set_slider_properties($MouthOptions/SquashMouth/SquashSlider,  2, -0.5, 0)
	set_slider_properties($MouthOptions/StretchMouth/StretchSlider,  2, -0.5, 0)

	
