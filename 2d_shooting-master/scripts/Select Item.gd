extends Control

var transitionfloor = preload("res://scenes/Maps/skip_floor.tscn")

func _ready():
	Global.number_of_floor += 1
	Global.itemselected = false
	while true:
		await get_tree().create_timer(0.1).timeout
		if Global.itemselected == false:
			pass
		if Global.itemselected == true:
			await get_tree().create_timer(5).timeout
			queue_free()
	
	

