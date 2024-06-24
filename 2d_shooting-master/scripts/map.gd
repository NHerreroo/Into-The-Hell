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
	pass
