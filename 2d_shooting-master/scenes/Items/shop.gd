extends Area2D
var numitem = 0
var price = 0

func get_random_number():
	numitem = randi() % 5 + 1 #36

func get_random_price():
	price = randi() % 14 + 7 #36

func _ready():
	$AnimationPlayer.play("item")
	get_random_price()
	get_random_number()
	if numitem == 1:
		$Sprite2D.play("cadencia")
	elif numitem == 2:
		$Sprite2D.play("daño")
	elif numitem == 3:
		$Sprite2D.play("vida")
	elif numitem == 4:
		$Sprite2D.play("velocity")
	elif numitem == 5:
		$Sprite2D.play("proyectil")

func _process(delta):
	$precio.text = str(price)

func _on_area_entered(area):
	if area.is_in_group("player"):
		if Global.monedas >= price:
			Global.monedas -= price
			queue_free()
