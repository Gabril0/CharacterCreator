extends Node3D

#UI References
var tabs = []
var eye_options
var mouth_options 
var nose_options 
var brow_options
var hair_options

func _ready():
	eye_options = $EyeBtn/EyeOptions
	mouth_options = $MouthBtn/MouthOptions
	nose_options = $NoseBtn/Options
	brow_options = $EyeBrowBtn/Options
	hair_options = $HairBtn/Options
	
	tabs.append(eye_options)
	tabs.append(mouth_options)
	tabs.append(nose_options)
	tabs.append(brow_options)
	tabs.append(hair_options)

func _on_eye_btn_pressed():
	eye_options.visible = !eye_options.visible
	close_tabs_except(eye_options.get_parent().name)

func _on_mouth_btn_pressed() -> void:
	mouth_options.visible = !mouth_options.visible
	close_tabs_except(mouth_options.get_parent().name)

func close_tabs_except(exception): #the exception is the tab that will stay open
	for tab in tabs:
		if tab.get_parent().name != exception:
			tab.visible = false


func _on_nose_btn_pressed() -> void:
	nose_options.visible = !nose_options.visible
	close_tabs_except(nose_options.get_parent().name)


func _on_brow_btn_pressed() -> void:
	brow_options.visible = !brow_options.visible
	close_tabs_except(brow_options.get_parent().name)


func _on_hair_btn_pressed() -> void:
	hair_options.visible = !hair_options.visible
	close_tabs_except(hair_options.get_parent().name)
