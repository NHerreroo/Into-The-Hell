extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.visible = true
	Global.camera = false
	await get_tree().create_timer(4).timeout
	$ColorRect/AnimationPlayer.play("cameraentry")
	await get_tree().create_timer(3).timeout
	Global.camera = true
	$Camera2D.enabled = false
	

func _process(delta):
	if Global.bossdefeat == true:
		$Agujero.visible = true
		$Agujero/Area2D/CollisionShape2D. disabled = false
	else:
		$Agujero.visible = false
		$Agujero/Area2D/CollisionShape2D. disabled = true


func _on_area_2d_area_entered(area):
		if area.is_in_group("player"):
			$Player.visible = false
			$ColorRect/AnimationPlayer.play("final")
			await get_tree().create_timer(2).timeout
			get_tree().change_scene_to_file("res://scenes/Maps/credits.tscn")
