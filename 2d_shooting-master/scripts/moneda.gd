extends StaticBody2D

func _ready():
	$AnimationPlayer.play("jump_coin")
	
func _on_area_2d_area_entered(area):
	if area.is_in_group("player"):
		Global.monedas += 1
		queue_free()
