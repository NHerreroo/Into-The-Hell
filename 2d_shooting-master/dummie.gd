extends CharacterBody2D

var damagepersec = 0
var time_since_last_shot = 0.0

func _ready():
	$Label.text = "0"

func _process(delta):
	if time_since_last_shot >= 2.0:
		damagepersec = 0
	$Label.text = str(damagepersec)
	time_since_last_shot += delta

func take_damage():
	$Sprite2D.play("new_animation")
	await get_tree().create_timer(0.1).timeout
	$Sprite2D.play("default")
	damagepersec += Global.daño
	time_since_last_shot = 0.0
