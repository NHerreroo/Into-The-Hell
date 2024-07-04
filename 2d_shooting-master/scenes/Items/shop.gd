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
		#Global.cadencia -= 0.025
	elif numitem == 2:
		$Sprite2D.play("daño")
		#Global.daño += 30
	elif numitem == 3:
		$Sprite2D.play("vida")
		#Global.health -= 3
	elif numitem == 4:
		$Sprite2D.play("velocity")
		#Global.velocidad += 60
	elif numitem == 5:
		$Sprite2D.play("proyectil")
		#Global.velocidadbala -= 100

func _process(delta):
	$precio.text = str(price)

func _on_area_entered(area):
	if area.is_in_group("player"):
		if Global.monedas >= price:
			Global.monedas -= price
			if numitem == 1:
				Global.cadencia -= 0.025
			if numitem == 2:
				Global.daño += 30
			if numitem == 3:
				Global.health -= 3
			if numitem == 4:
				Global.velocidad += 60
			if numitem == 5:
				Global.velocidadbala -= 100
			queue_free()
