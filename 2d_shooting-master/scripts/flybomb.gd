extends CharacterBody2D

var blood = preload("res://scenes/Enemies/blood.tscn")
var moneda = preload("res://scenes/Items/moneda.tscn")
var bala_enemy = preload("res://scenes/Enemies/balas/bala_enemy.tscn")

var speed = 200
var accel = 7
var health = 50
var repelForce = 300  # Adjust as needed
@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("player")
@onready var nav : NavigationAgent2D = $NavigationAgent2D

func _ready():
	$bomb.play("idle")

func _physics_process(delta):
	if Global.death == true:
		queue_free()
		
	var direction = Vector3()
	nav.target_position = player.position
	
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * speed , accel * delta)
	move_and_slide()


#repel
func _on_area_2d_body_entered(body):
	if body.is_in_group("mobs"):
		var repelDirection = (global_position - body.global_position).normalized()
		velocity += repelDirection * repelForce

func take_damage():
	health -= Global.daño
	$bomb.play("damage")
	await get_tree().create_timer(0.1).timeout
	$bomb.play("idle")
	if health <= 0:
		Global.enemies_on_screen -= 1 
		print(self.position)
		bloodInstance()
		money()
		shoot_in_8_directions()  # Llamada a la función para disparar en 8 direcciones
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
		var bala_instance = bala_enemy.instantiate()
		bala_instance.position = self.position
		bala_instance.direction = direction
		get_tree().root.add_child(bala_instance)
