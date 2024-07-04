extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Map/ColorRect3.visible = false
	$Player.visible = true
	Global.camera = false
	await get_tree().create_timer(4).timeout
	$ColorRect/AnimationPlayer.play("cameraentry")
	await get_tree().create_timer(3).timeout
	Global.camera = true
	$Camera2D.enabled = false
	while true:
		await get_tree().create_timer(1).timeout
		if Global.secondphaseboss == true:
			$Map/ColorRect3.visible = true
			$ColorRect/AnimationPlayer.play("secondphase")
			break
	

func _process(delta):
	Global.agujero_position = $Agujero.position
	if Global.bossdefeat == true:
		$Agujero.visible = true
		$Agujero/Area2D/CollisionShape2D. disabled = false
	else:
		$Agujero.visible = false
		$Agujero/Area2D/CollisionShape2D. disabled = true
	if Global.secondphaseboss == true:
		$Map/ColorRect3.visible = true
		



func _on_area_2d_area_entered(area):
		if area.is_in_group("player"):
			Global.secondphaseboss = false
			$Player.visible = false
			$ColorRect/AnimationPlayer.play("final")
			await get_tree().create_timer(1.5).timeout
			get_tree().change_scene_to_file("res://scenes/Maps/credits.tscn")
