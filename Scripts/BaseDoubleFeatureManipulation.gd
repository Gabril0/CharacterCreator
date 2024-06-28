extends Button

#Feature properties
var feature_left
var original_feature_left_position
var original_feature_left_scale
var original_feature_left_rotation

var feature_right
var original_feature_right_position
var original_feature_right_scale
var original_feature_right_rotation

var is_holding_feature_left_rotation
var is_holding_feature_right_rotation

var item_list = []

#UI References
var feature_options
@onready var head: Node3D = $"../../Head"
	
func set_slider_properties(slider, max_value, min_value, value):
	slider.value = value
	slider.max_value = max_value
	slider.min_value = min_value

func _process(delta):
	if(is_holding_feature_left_rotation):
		rotate_features(1*delta,-1*delta)
	if(is_holding_feature_right_rotation):
		rotate_features(-1*delta,1*delta)
	pass

func _on_position_slider_value_changed(value):
	feature_left.position = Vector3(original_feature_left_position.x + value, feature_left.position.y, feature_left.position.z)
	feature_right.position = Vector3(original_feature_right_position.x - value, feature_right.position.y, feature_right.position.z)


func _on_feature_size_value_changed(value: float) -> void:
	#Godot doesn't like very small numbers when the scale is 0, so it does this
	feature_left.scale = Vector3(original_feature_left_scale.x - value - 0.001, original_feature_left_scale.y - 0.001, original_feature_left_scale.z - value - 0.001)
	feature_right.scale = Vector3(original_feature_right_scale.x + value + 0.001, original_feature_right_scale.y + 0.001, original_feature_right_scale.z + value + 0.001)
	
func rotate_features(left_rotation, right_rotation):
	var left_x_rotation =  left_rotation
	var right_x_rotation =  right_rotation
	feature_left.rotate_z(left_x_rotation)
	feature_right.rotate_z(right_x_rotation)


func _on_feature_rotation_left_button_down() -> void:
	is_holding_feature_left_rotation = true


func _on_feature_rotation_left_button_up() -> void:
	is_holding_feature_left_rotation = false


func _on_feature_rotation_right_button_down() -> void:
	is_holding_feature_right_rotation = true


func _on_feature_rotation_right_button_up() -> void:
	is_holding_feature_right_rotation = false

func _on_feature_height_value_changed(value: float) -> void:
	var new_left = Vector3(feature_left.position.x, original_feature_left_position.y + value, feature_left.position.z)
	var new_right = Vector3(feature_right.position.x, original_feature_right_position.y + value, feature_right.position.z)
	feature_left.position = new_left
	feature_right.position = new_right

func _on_stretch_features_slider_value_changed(value: float) -> void:
	feature_left.scale = Vector3(original_feature_left_scale.x - value, feature_left.scale.y, feature_left.scale.z)
	feature_right.scale = Vector3(original_feature_right_scale.x + value, feature_right.scale.y, feature_right.scale.z)


func _on_squash_features_slider_value_changed(value: float) -> void:
	feature_left.scale = Vector3(feature_left.scale.x , feature_left.scale.y, original_feature_left_scale.z - value)
	feature_right.scale = Vector3(feature_right.scale.x , feature_right.scale.y, original_feature_right_scale.z + value)


func _on_color_picker_button_color_changed(color: Color) -> void:
	feature_left.modulate = color
	feature_right.modulate = color
	
func _on_item_list_item_selected(index: int) -> void:
	feature_left.textures.albedo = item_list[index]
	feature_right.textures.albedo = item_list[index]

