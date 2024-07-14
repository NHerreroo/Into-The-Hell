extends CharacterBody2D

var blood = preload("res://scenes/Enemies/blood.tscn")
var moneda = preload("res://scenes/Items/moneda.tscn")
var bullet = preload("res://scenes/Enemies/balas/bala_enemy.tscn")

var fly = preload("res://scenes/Enemies/fly.tscn")
var flybomb = preload("res://scenes/Enemies/flybomb.tscn")

var speed = 0
var accel = 7
var health = 13000
var repelForce = 300
var sprite = "idle"

var wait = 0.05
var num = 0
var waitatk = 5

@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("player")
@onready var nav : NavigationAgent2D = $NavigationAgent2D

func get_random_number():
	num = randi() % 2 + 1 #36
	
func _ready():
	$CanvasLayer/ProgressBar.max_value = health
	$CanvasLayer/ProgressBar.value = health
	$AnimationPlayer.play("idle")
	await get_tree().create_timer(7).timeout
	while health > 0:
		ocultarse()
		await get_tree().create_timer(waitatk).timeout
		disparar()
		await get_tree().create_timer(waitatk).timeout
		shooting = false

func _process(delta):
	if Global.death == true:
		queue_free()
	$CanvasLayer/ProgressBar.value = health
	if health <= 4000:
		Global.secondphaseboss = true
		waitatk = 2
		
		

func _physics_process(delta):
	var direction = Vector2()
	nav.target_position = player.position
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	velocity = velocity.lerp(direction * speed, accel * delta)
	move_and_slide()

func _on_area_2d_body_entered(body):
	if body.is_in_group("mobs"):
		var repelDirection = (global_position - body.global_position).normalized()
		velocity += repelDirection * repelForce

func take_damage():
	health -= Global.daño
	$Godeye.visible = false
	await get_tree().create_timer(0.1).timeout
	$Godeye.visible = true
	if health <= 0:
		Global.bossdefeat = true
		bloodInstance()
		money()
		queue_free()

func money():
	var num = randi() % 4 + 1
	if num == 1:
		var penny = moneda.instantiate()
		penny.position = self.position
		get_tree().root.add_child(penny)

func bloodInstance():
	var blood_instance = blood.instantiate()
	blood_instance.position = self.position
	get_tree().root.add_child(blood_instance)


func ocultarse():
	speed = 140

var shooting = false

func disparar():
	speed = 0
	shooting = true
	#$WormBosas.play("shoot")
	get_random_number()
	if num == 1:
		while shooting:
			if Global.secondphaseboss == true:
				shoot_at_player_random()
				await get_tree().create_timer(0.1).timeout
			else:
				shoot_at_player()
				await get_tree().create_timer(wait).timeout
	elif num == 2:
		while shooting:
			if Global.secondphaseboss == true:
				shoot_in_32_directions()
			else:
				shoot_in_16_directions()
			await get_tree().create_timer(wait).timeout
		
func shoot_at_player():
	var bala_instance = bullet.instantiate()
	bala_instance.position = self.position
	# Calcular la dirección hacia el jugador
	var direction_to_player = (player.position - self.position).normalized()
	bala_instance.direction = direction_to_player
	get_tree().root.add_child(bala_instance)


func shoot_in_16_directions():
	var directions = []
	var num_directions = 16
	var angle_step = 360.0 / num_directions
	
	for i in range(num_directions):
		var angle = deg_to_rad(angle_step * i)
		var direction = Vector2(cos(angle), sin(angle))
		directions.append(direction)
	
	for direction in directions:
		var bala_instance = bullet.instantiate()
		bala_instance.position = self.position
		var direction_to_player = (player.position - self.position).normalized()
		bala_instance.direction = direction
		get_tree().root.add_child(bala_instance)
		

func shoot_in_32_directions():
	var directions = []
	var num_directions = 26
	var angle_step = 360.0 / num_directions
	
	for i in range(num_directions):
		var angle = deg_to_rad(angle_step * i)
		var direction = Vector2(cos(angle), sin(angle))
		directions.append(direction)
	
	for direction in directions:
		var bala_instance = bullet.instantiate()
		bala_instance.position = self.position
		var direction_to_player = (player.position - self.position).normalized()
		bala_instance.direction = direction
		get_tree().root.add_child(bala_instance)


var num1 = 0
var num2 = 0

func get_random_pos():
	num1 = randi_range(-257, 606)
	num2 = randi_range(-76, 385)
	
func shoot_at_player_random():
	var bala_instance = bullet.instantiate()
	get_random_pos()
	bala_instance.position.x = num1
	bala_instance.position.y = num2
	# Calcular la dirección hacia el jugador
	var direction_to_player = (player.position - self.position).normalized()
	bala_instance.direction = direction_to_player
	get_tree().root.add_child(bala_instance)

