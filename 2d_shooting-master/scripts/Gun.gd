extends Sprite2D

@export var speed = 200
var bullet_scene = preload("res://scenes/Player/bullet.tscn")
var can_shoot = true
var reload = false

func _ready():
	$"../reloadbar".play("default")

var angle = 0.0

func get_input():
	look_at(get_global_mouse_position())

	angle = fmod(rotation_degrees, 360.0)

	if (angle > 90.0 and angle < 270.0) or (angle < -90.0 and angle > -270.0):
		flip_v = true
	else:
		flip_v = false



	if (angle > 90 and angle < 270) or (angle < -90 and angle > -270):
		flip_v = true
	else:
		flip_v = false

	

	
	if Input.is_action_pressed("shoot") and can_shoot and !reload:
		if Global.current_bullets <= Global.max_bulelts:
			shoot()
			Global.current_bullets -= 1
		if Global.current_bullets <= 0:
			reloadgun()
		
func _physics_process(delta):
	get_input()


func  _process(delta):
	if reload == true:
		$"../reloadbar".visible = true
	elif reload == false:
		$"../reloadbar".visible = false
	
func shoot():
	$"../Camera2D/AnimationPlayer".play("cam_zoom")

	var b = bullet_scene.instantiate()
	get_tree().root.add_child(b)
	b.transform = $Muzzle.global_transform
	can_shoot = false
	await get_tree().create_timer(Global.cadencia).timeout
	can_shoot = true


func reloadgun():
	reload = true
	await get_tree().create_timer(Global.recarga).timeout
	Global.current_bullets = Global.max_bulelts
	reload = false

		
