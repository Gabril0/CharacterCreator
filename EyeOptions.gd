extends Button

#Eye properties
var eye_left
var original_eye_left_position
var original_eye_left_scale
var original_eye_left_rotation

var eye_right
var original_eye_right_position
var original_eye_right_scale
var original_eye_right_rotation

var is_holding_eye_left_rotation
var is_holding_eye_right_rotation

#UI References
var eye_options
@onready var head: Node3D = $"../../Head"

func _ready():
	#body references
	var decals = head.find_child("Decals", true)
	eye_left = decals.find_child("LeftEye", true)
	original_eye_left_position = eye_left.position
	original_eye_left_scale = eye_left.scale
	original_eye_left_rotation = eye_left.rotation
	eye_right = decals.find_child("RightEye", true)
	original_eye_right_position = eye_right.position
	original_eye_right_scale = eye_right.scale
	original_eye_right_rotation = eye_right.rotation
	
	eye_options = $EyeOptions
	
	
	var eye_distance_slider = $EyeOptions/EyeDistance/HSlider
	eye_distance_slider.value = 0
	eye_distance_slider.max_value = 0.15
	
	var eye_scale_slider = $EyeOptions/EyeSize/EyeSize
	eye_scale_slider.value = 0
	eye_scale_slider.max_value = .5
	eye_scale_slider.min_value = -.5
	
	var eye_height_slider = $EyeOptions/EyeHeight/EyeHeight
	eye_height_slider.value = 0
	eye_height_slider.max_value = 0.5
	eye_height_slider.min_value = -0.5
	
	var eye_


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(is_holding_eye_left_rotation):
		rotate_eyes(1*delta,-1*delta)
	if(is_holding_eye_right_rotation):
		rotate_eyes(-1*delta,1*delta)
	pass


func _on_eye_btn_pressed():
	eye_options.visible = !eye_options.visible


func _on_h_slider_value_changed(value):
	eye_left.position = Vector3(original_eye_left_position.x + value, eye_left.position.y, eye_left.position.z)
	eye_right.position = Vector3(original_eye_right_position.x - value, eye_right.position.y, eye_right.position.z)


func _on_eye_size_value_changed(value: float) -> void:
	#Godot doesn't like very small numbers when the scale is 0, so it does this
	eye_left.scale = Vector3(original_eye_left_scale.x - value - 0.001, original_eye_left_scale.y - 0.001, original_eye_left_scale.z - value - 0.001)
	eye_right.scale = Vector3(original_eye_right_scale.x + value + 0.001, original_eye_right_scale.y + 0.001, original_eye_right_scale.z + value + 0.001)
	
func rotate_eyes(left_rotation, right_rotation):
	var left_x_rotation =  left_rotation
	var right_x_rotation =  right_rotation


	eye_left.rotate_z(left_x_rotation)
	eye_right.rotate_z(right_x_rotation)


func _on_eye_rotation_left_button_down() -> void:
	is_holding_eye_left_rotation = true


func _on_eye_rotation_left_button_up() -> void:
	is_holding_eye_left_rotation = false


func _on_eye_rotation_right_button_down() -> void:
	is_holding_eye_right_rotation = true


func _on_eye_rotation_right_button_up() -> void:
	is_holding_eye_right_rotation = false

func _on_eye_height_value_changed(value: float) -> void:
	var new_left = Vector3(eye_left.position.x, original_eye_left_position.y + value, eye_left.position.z)
	var new_right = Vector3(eye_right.position.x, original_eye_right_position.y + value, eye_right.position.z)
	eye_left.position = new_left
	eye_right.position = new_right

func _on_stretch_eyes_slider_value_changed(value: float) -> void:
	eye_left.scale = Vector3(original_eye_left_scale.x - value, eye_left.scale.y, eye_left.scale.z)
	eye_right.scale = Vector3(original_eye_right_scale.x + value, eye_right.scale.y, eye_right.scale.z)


func _on_squash_eyes_slider_value_changed(value: float) -> void:
	eye_left.scale = Vector3(eye_left.scale.x , eye_left.scale.y, original_eye_left_scale.z - value)
	eye_right.scale = Vector3(eye_right.scale.x , eye_right.scale.y, original_eye_right_scale.z + value)


func _on_color_picker_button_color_changed(color: Color) -> void:
	print("changed to " + str(color))
	eye_left.modulate = color
	eye_right.modulate = color
