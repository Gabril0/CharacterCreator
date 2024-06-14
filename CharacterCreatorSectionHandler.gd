extends Node3D

#UI References
var tabs = []
var eye_options
var mouth_options 

func _ready():
	eye_options = $EyeBtn/EyeOptions
	mouth_options = $MouthBtn/MouthOptions
	tabs.append(eye_options)
	tabs.append(mouth_options)



func _on_eye_btn_pressed():
	eye_options.visible = !eye_options.visible
	close_tabs_except(eye_options.name)


func _on_mouth_btn_pressed() -> void:
	mouth_options.visible = !mouth_options.visible
	close_tabs_except(mouth_options.name)
	
func close_tabs_except(exception): #the exception is the tab that will stay open
	for tab in tabs:
		if tab.name != exception:
			tab.visible = false
