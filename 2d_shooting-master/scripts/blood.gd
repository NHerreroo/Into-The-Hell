extends Node2D

var num = 0

func get_random():
	num = randi() % 6 + 1

# Called when the node enters the scene tree for the first time.
func _ready():
	get_random()
	if num == 1:
		$Blood1.play("1")
	if num == 2:
		$Blood1.play("2")
	if num == 3:
		$Blood1.play("3")
	if num == 4:
		$Blood1.play("4")
	if num == 5:
		$Blood1.play("5")
	if num == 6:
		$Blood1.play("6")
	await get_tree().create_timer(7).timeout
	$AnimationPlayer.play("desaparecer")
	await get_tree().create_timer(1).timeout
	queue_free()

