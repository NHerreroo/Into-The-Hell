extends Area2D

var numitem = 0

func get_random_number():
	numitem = randi() % 3 + 1 #36

# Called when the node enters the scene tree for the first time.
func _ready():
	get_random_number()
	if numitem == 1:
		$AnimationPlayer.play("atack1")
	elif numitem == 2:
		$AnimationPlayer.play("atack3")
	elif numitem == 3:
		$AnimationPlayer.play("atack")
	await get_tree().create_timer(3).timeout
	queue_free()
	
	
