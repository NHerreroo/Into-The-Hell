extends Control

func _ready():
	$ColorRect.visible = true
	Engine.time_scale = 1
	$Button.disabled = false
	$AnimationPlayer.play("fadein")
	await get_tree().create_timer(2).timeout
	$ColorRect.visible = false
	
func _on_button_pressed():
	$Button.disabled = true
	$ColorRect.visible = true
	$AnimationPlayer.play("fadeout")
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://scenes/Player/title_sceern.tscn")
