extends CharacterBody2D

var blood = preload("res://scenes/Enemies/blood.tscn")
var moneda = preload("res://scenes/Items/moneda.tscn")
var bullet = preload("res://scenes/Enemies/balas/bala_enemy.tscn")

var speed = 0
var accel = 7
var health = 10000
var repelForce = 300
var sprite = "idle"

var wait = 0.5

@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("player")
@onready var nav : NavigationAgent2D = $NavigationAgent2D

func _ready():
	$CanvasLayer/ProgressBar.max_value = health
	$CanvasLayer/ProgressBar.value = health
	$slimeboss.play("idle")
	await get_tree().create_timer(7).timeout
	speed = 50
	while health > 0:
		caminar()
		await get_tree().create_timer(3).timeout
		atacarsalto()
		await get_tree().create_timer(5).timeout
		jumping = false

func _process(delta):
	if Global.death == true:
		queue_free()
		
	$CanvasLayer/ProgressBar.value = health
	if health <= 4000:
		wait = 0.2

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
	$slimeboss.play("damage")
	await get_tree().create_timer(0.1).timeout
	$slimeboss.play(str(sprite))
	if health <= 0:
		Global.godbattle = true
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

func caminar():
	sprite = "idle"
	$slimeboss.play("idle")
	speed = 30
		
		
var jumping = false
func atacarsalto():
	sprite = "jump"
	jumping = true
	speed = 0
	$slimeboss.play("jump")
	while jumping:
		shoot_in_8_directions()
		await get_tree().create_timer(wait).timeout
		shoot_in_other_8_directions()
		await get_tree().create_timer(wait).timeout
	
	
func shoot_in_8_directions():
	var directions = [
		Vector2(1, 0),
		Vector2(1, 1).normalized(),
		Vector2(0, 1),
		Vector2(-1, 1).normalized(),
		Vector2(-1, 0),
		Vector2(-1, -1).normalized(),
		Vector2(0, -1),
		Vector2(1, -1).normalized()
	]
	
	for direction in directions:
		var bala_instance = bullet.instantiate()
		bala_instance.position = self.position
		bala_instance.direction = direction
		get_tree().root.add_child(bala_instance)

func shoot_in_other_8_directions():
	var directions2 = [
		Vector2(0.5, -1).normalized(),
		Vector2(1, -0.5).normalized(),
		Vector2(1, 0.5).normalized(),
		Vector2(0.5, 1).normalized(),
		Vector2(-0.5, 1).normalized(),
		Vector2(-1, 0.5).normalized(),
		Vector2(-1, -0.5).normalized(),
		Vector2(-0.5, -1).normalized()
	]
	
	for direction in directions2:
		var bala_instance = bullet.instantiate()
		bala_instance.position = self.position
		bala_instance.direction = direction
		get_tree().root.add_child(bala_instance)
