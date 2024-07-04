extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.shop = false
	Global.nodamage = true
	
	$Torch.play("default")
	$Torch2.play("default")
	$Torch3.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.secondphaseboss == true:
		$CollisionPolygon2D.disabled = true
	else:
		$CollisionPolygon2D.disabled = false
		


func _on_area_2d_area_entered(area):
	if area.is_in_group("player"):
		queue_free()
