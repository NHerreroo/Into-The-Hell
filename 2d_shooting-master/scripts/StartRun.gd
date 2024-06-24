extends Control


#eempieza la run
func _on_yes_pressed():
	Engine.time_scale = 1
	Global.run_start = true
	get_tree().change_scene_to_file("res://scenes/Maps/main.tscn")
	
#no empieza la run
func _on_no_pressed():
	Engine.time_scale = 1
	self.visible = false
