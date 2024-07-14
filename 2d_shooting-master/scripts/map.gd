extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.shop = false
	Global.nodamage = true
	await get_tree().create_timer(4).timeout
	$AudioStreamPlayer2D.play()
	$Torch.play("default")
	$Torch2.play("default")
	$Torch3.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.secondphaseboss == true:
		$CollisionPolygon2D.disabled = true
		$Area2D/CollisionPolygon2D2.disabled = true
	else:
		$CollisionPolygon2D.disabled = false
		$Area2D/CollisionPolygon2D2.disabled = false
	if Global.death == true:
		$AudioStreamPlayer2D.stop()


func _on_area_2d_area_entered(area):
	if area.is_in_group("player"):
		queue_free()
