extends Button

#Feature properties
var feature
var original_feature_position
var original_feature_scale
var original_feature_rotation

var is_holding_feature_left_rotation
var is_holding_feature_right_rotation

#UI References
var feature_options
@onready var head: Node3D = $"../../Head"
	
func set_slider_properties(slider, max_value, min_value, value):
	slider.value = value
	slider.max_value = max_value
	slider.min_value = min_value

func _process(delta):
	if(is_holding_feature_left_rotation):
		rotate_features(1*delta)
	if(is_holding_feature_right_rotation):
		rotate_features(-1*delta)
	pass

func _on_position_slider_value_changed(value):
	feature.position = Vector3(original_feature_position.x + value, feature.position.y, feature.position.z)


func _on_feature_size_value_changed(value: float) -> void:
	#Godot doesn't like very small numbers when the scale is 0, so it does this
	feature.scale = Vector3(original_feature_scale.x - value - 0.001, original_feature_scale.y - 0.001, original_feature_scale.z - value - 0.001)
	
func rotate_features(rotation_increment):
	feature.rotate_z(rotation_increment)


func _on_feature_rotation_left_button_down() -> void:
	is_holding_feature_left_rotation = true


func _on_feature_rotation_left_button_up() -> void:
	is_holding_feature_left_rotation = false


func _on_feature_rotation_right_button_down() -> void:
	is_holding_feature_right_rotation = true


func _on_feature_rotation_right_button_up() -> void:
	is_holding_feature_right_rotation = false

func _on_feature_height_value_changed(value: float) -> void:
	var new_feature = Vector3(feature.position.x, original_feature_position.y + value, feature.position.z)
	feature.position = new_feature


func _on_stretch_features_slider_value_changed(value: float) -> void:
	feature.scale = Vector3(original_feature_scale.x - value, feature.scale.y, feature.scale.z)

func _on_squash_features_slider_value_changed(value: float) -> void:
	feature.scale = Vector3(feature.scale.x , feature.scale.y, original_feature_scale.z - value)

func _on_color_picker_button_color_changed(color: Color) -> void:
	feature.modulate = color

