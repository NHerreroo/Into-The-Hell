extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("entry and fade")
	$AnimatedSprite2D.play("idle")
	await get_tree().create_timer(10).timeout
	get_tree().change_scene_to_file("res://scenes/Player/title_sceern.tscn")
	
