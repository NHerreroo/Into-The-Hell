extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = true
	$AnimatedSprite2D.play("default")
	await get_tree().create_timer(4).timeout
	self.visible = false
	$"../../../ColorRect/AnimationPlayer".play("entry")
	
