extends Area2D

var speed = Global.velocidadbala
var is_bullet_deleted = false

func _ready():
	if Global.secondphaseboss == true:
		$PointLight2D.visible = false
	else:
		$PointLight2D.visible = true
	$Sprite2d.play("Bullet1")
	await get_tree().create_timer(10).timeout
	look_at(get_global_mouse_position())
	queue_free()
	

func _process(delta):
	if Global.death == true:
		queue_free()
	
func _physics_process(delta):
	position += transform.x * speed * delta

func _on_bullet_body_entered(body):
	if body.is_in_group("mobs"):
		if body.has_method("take_damage"):  # Verifica si el enemigo tiene un método take_damage
			body.take_damage()  # Llama al método take_damage del enemigo
		if Global.piercing == false: 
			#is_bullet_deleted = false
			queue_free()  # Eliminar la bala
	if body.is_in_group("dumie"):
		if body.has_method("take_damage"):  # Verifica si el enemigo tiene un método take_damage
			body.take_damage()  # Llama al método take_damage del enemigo
			queue_free()
	if body.is_in_group("wall"):
			#is_bullet_deleted = false
			queue_free()  # Eliminar la bala	
			
