extends StaticBody2D


func _ready():
	if Global.number_of_floor == 1:
		$Controls.visible = true
	else:
		$Controls.visible = false
	$Player/CanvasLayer/FreeItem.visible = false
	$ColorRect2/AnimationPlayer.play("entry")
	$Player/CanvasLayer/StartRun.visible = false
	$Lobby/torch.play("default")
	$Lobby/torch3.play("default")
	$Lobby/torch4.play("default")
	$Lobby/torch5.play("default")
	$stranger.play("default")
	$bar.play("idle")
	Global.itemselected = false
	Global.itemcasino = false
	Global.death = false
	if Global.number_of_floor == 5:
		$round.text = "BOSS"
	else:
		$round.text = "ROOM " + str(Global.number_of_floor)
func _on_area_2d_area_entered(area):
	if area.is_in_group("player"):
		if Global.run_start == true:
			get_tree().change_scene_to_file("res://scenes/Maps/main.tscn")
		Engine.time_scale = 0
		$Player/CanvasLayer/StartRun.visible = true
	



func _on_shop_area_entered(area):
	if area.is_in_group("player"):
		$Player/CanvasLayer/FreeItem.visible = true
func _on_shop_area_exited(area):
	if area.is_in_group("player"):
		$Player/CanvasLayer/FreeItem.visible = false


func _on_maquinacoll_area_entered(area):
	if area.is_in_group("player"):
		if Global.itemcasino == false:
			$Mauina.play("active")
			await get_tree().create_timer(2).timeout
			$Mauina.play("quemada")
			Global.itemcasino = true
		if Global.itemcasino == true:
			$Player/CanvasLayer/casinocard.visible = true

func _process(delta):
	Global.shop = true
	if Global.nodamage == false:
		$"puerta casino".play("cerrada")
		$puertacasinocollision.disabled = false
	elif Global.nodamage == true:
		$"puerta casino".play("default")
		$puertacasinocollision.disabled = true


func _on_casinofllor_area_entered(area):
	if area.is_in_group("player"):
		if Global.itemcasino == true:
			$Player/CanvasLayer/casinocard.visible = true


func _on_casinofllor_area_exited(area):
	if area.is_in_group("player"):
		if Global.itemcasino == true:
			$Player/CanvasLayer/casinocard.visible = false
