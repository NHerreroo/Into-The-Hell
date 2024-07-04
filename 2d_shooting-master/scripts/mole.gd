extends CharacterBody2D

var blood = preload("res://scenes/Enemies/blood.tscn")
var moneda = preload("res://scenes/Items/moneda.tscn")
var bullet = preload("res://scenes/Enemies/balas/bala_enemy.tscn")  # Cargar la escena de la bala

var speed = 200
var accel = 7
var health = 100
var repelForce = 300  # Ajustar según sea necesario

var num1
var num2

@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("player")
@onready var nav : NavigationAgent2D = $NavigationAgent2D

func _process(delta):
	if Global.death == true:
		queue_free()
		
func get_random_pos():
	num1 = randi_range(-257, 500)
	num2 = randi_range(-76, 300)
	
func _ready():
	health = health * Global.number_of_floor
	while true:
		$CollisionShape2D.disabled = false
		$topo.play("entra")
		$topo/shadow.visible = true
		await get_tree().create_timer(0.35).timeout
		$topo.play("default")
		shoot_in_four_directions()  # Llamar a la función para disparar en cuatro direcciones
		await get_tree().create_timer(3).timeout
		$topo.play("sale")
		await get_tree().create_timer(0.35).timeout
		$topo.play("esconde")
		$topo/shadow.visible = false
		$CollisionShape2D.disabled = true
		await get_tree().create_timer(3).timeout
		get_random_pos()
		self.position.x = num1
		self.position.y = num2
		

func shoot_in_four_directions():
	var directions = [
		Vector2(0, -1),  # Arriba
		Vector2(0, 1),   # Abajo
		Vector2(-1, 0),  # Izquierda
		Vector2(1, 0)    # Derecha
	]
	
	for direction in directions:
		var bullet_instance = bullet.instantiate()
		bullet_instance.position = self.position
		bullet_instance.direction = direction
		get_tree().root.add_child(bullet_instance)


#función para repeler
func take_damage():
	health -= Global.daño
	$topo.play("damage")
	await get_tree().create_timer(0.1).timeout
	$topo.play("default")
	if health <= 0:
		Global.enemies_on_screen -= 1 
		print(self.position)
		bloodInstance()
		money()
		queue_free()


func money():
	var num = 0
	num = randi() % 3 + 1
	print(num)
	if  num == 1:
		var penny = moneda.instantiate()
		penny.position = self.position
		get_tree().root.add_child(penny)
	else:
		pass
	
func bloodInstance():
	var blood_instance = blood.instantiate()
	blood_instance.position = self.position
	get_tree().root.add_child(blood_instance)
