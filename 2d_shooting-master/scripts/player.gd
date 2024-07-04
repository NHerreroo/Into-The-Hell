extends CharacterBody2D

@export var speed = Global.velocidad
@export var dash_speed = 600
@export var dash_duration = 0.35
@export var dash_cooldown = 2.0

var is_dashing = false
var dash_timer = 0.0
var dash_direction = Vector2.ZERO
var dash_cooldown_timer = 0.0

func get_input():
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = velocity.lerp(direction * speed, 0.15) # Ajusta el valor de interpolación según lo desees
	
	if Input.is_action_pressed("dash") and not is_dashing and dash_cooldown_timer <= 0.0:
		is_dashing = true
		dash_timer = dash_duration
		dash_direction = direction.normalized()
		dash_cooldown_timer = dash_cooldown

func _ready():
	$Damage/Damage.visible = false
	
func _process(delta):
	if Global.bossdefeat == true:
		$Flecha.visible = true
	else:
		$Flecha.visible = false
	$Flecha.look_at(Vector2(140,94))
	if Global.health >= 11:
		#Global.godbattle = false
		Global.death = true
		$Death.visible = true
		Engine.time_scale = 0.5
		$Damage/death2.visible = true
		$Damage/Damage/AnimationPlayer.play("fadedeath")
		$AudioStreamPlayer2D.play()
		await get_tree().create_timer(2).timeout
		Engine.time_scale = 1
		get_tree().change_scene_to_file("res://scenes/Player/dead.tscn")
		
		
		
	elif Global.health <= 11:
		$Death.visible = false
		Global.death = false
	
	if Global.health < 1:
		Global.health = 1
		
		
func _physics_process(delta):
	speed = Global.velocidad
	$Gun1/Muzzle.scale.x = Global.bullet_sizeX;
	$Gun1/Muzzle.scale.y = Global.bullet_sizeY;
	if damagecoldown == true:
		$CollisionShape2D.disabled = true
		$Area2D/CollisionShape2D.disabled = true
	elif damagecoldown == false:
		$CollisionShape2D.disabled = false
		$Area2D/CollisionShape2D.disabled = false
	get_input()
	
	$Character.flip_h = false
	
	if Input.is_action_pressed("down"):
		$Character.play("down")
	elif Input.is_action_pressed("up"):
		$Character.play("up")
	elif Input.is_action_pressed("left"):
		$Character.flip_h = true
		$Character.play("walkizqueria")
	elif Input.is_action_pressed("right"):
		$Character.play("walkderecha")
	else:
		$Character.play("idle")
	
	if is_dashing:
		$CollisionShape2D.disabled
		velocity = dash_direction * dash_speed
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false
			$CollisionShape2D.disabled = false
			velocity = Vector2.ZERO

	if dash_cooldown_timer > 0.0:
		dash_cooldown_timer -= delta

	move_and_slide()

var damagecoldown = false
func _on_area_2d_body_entered(body):
	if body.is_in_group("mobs"):
		if damagecoldown == false:
			damagecoldown = true
			Global.nodamage = false
			Global.health += 1
			$Damage/Damage.visible = true
			$Damage/Damage/AnimationPlayer.play("takedamage")
			await get_tree().create_timer(1).timeout
			damagecoldown = false


func _on_area_2d_area_entered(area):
	if area.is_in_group("limits"):
		$".".position = Vector2(146, 138)
	
	if area.is_in_group("balaenemy"):
		if damagecoldown == false:
			damagecoldown = true
			Global.nodamage = false
			Global.health += 1
			$Damage/Damage.visible = true
			$Damage/Damage/AnimationPlayer.play("takedamage")
			await get_tree().create_timer(1).timeout
			damagecoldown = false
		
