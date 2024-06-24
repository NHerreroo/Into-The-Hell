extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(1).timeout
	$CanvasLayer/ColorRect/AnimatedSprite2D.play()
	$AnimationPlayer.play("flor2-3")
	await get_tree().create_timer(7).timeout
	queue_free()
	if Global.number_of_floor == 5:
		get_tree().change_scene_to_file("res://scenes/Maps/Boss_Slime_bttl.tscn")
	else: 
		get_tree().change_scene_to_file("res://scenes/Maps/lobby.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$CanvasLayer/ColorRect/Label.text = str("Floor n", Global.number_of_floor)
