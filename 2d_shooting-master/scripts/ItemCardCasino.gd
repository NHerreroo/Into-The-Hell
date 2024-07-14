extends Button
var transitionfloor = preload("res://scenes/Maps/skip_floor.tscn")

@export var angle_x_max: float = 15.0
@export var angle_y_max: float = 15.0
@export var max_offset_shadow: float = 50.0

@export_category("Oscillator")
@export var spring: float = 150.0
@export var damp: float = 10.0
@export var velocity_multiplier: float = 2.0

var displacement: float = 0.0 
var oscillator_velocity: float = 0.0

var tween_rot: Tween
var tween_hover: Tween
var tween_destroy: Tween
var tween_handle: Tween

var last_mouse_pos: Vector2
var mouse_velocity: Vector2
var following_mouse: bool = false
var last_pos: Vector2
var velocity: Vector2


@onready var card_texture: TextureRect = $CardTexture
@onready var shadow = $Shadow
@onready var collision_shape = $DestroyArea/CollisionShape2D

func _ready() -> void:
	selectItem()
	Global.itemcasinoselected = false
	# Convert to radians because lerp_angle is using that
	angle_x_max = deg_to_rad(angle_x_max)
	angle_y_max = deg_to_rad(angle_y_max)
	collision_shape.set_deferred("disabled", true)

func _process(delta: float) -> void:
	rotate_velocity(delta)
	follow_mouse(delta)
	handle_shadow(delta)
	
func destroy() -> void:
	card_texture.use_parent_material = true
	if tween_destroy and tween_destroy.is_running():
		tween_destroy.kill()
	tween_destroy = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween_destroy.tween_property(material, "shader_parameter/dissolve_value", 0.0, 2.0).from(1.0)
	tween_destroy.parallel().tween_property(shadow, "self_modulate:a", 0.0, 1.0)

func rotate_velocity(delta: float) -> void:
	if not following_mouse: return
	var center_pos: Vector2 = global_position - (size/2.0)
	# Compute the velocity
	velocity = (position - last_pos) / delta
	last_pos = position
	oscillator_velocity += velocity.normalized().x * velocity_multiplier
	
	# Oscillator stuff
	var force = -spring * displacement - damp * oscillator_velocity
	oscillator_velocity += force * delta
	displacement += oscillator_velocity * delta
	
	rotation = displacement

func handle_shadow(delta: float) -> void:
	# Y position is enver changed.
	# Only x changes depending on how far we are from the center of the screen
	var center: Vector2 = get_viewport_rect().size / 2.0
	var distance: float = global_position.x - center.x
	
	shadow.position.x = lerp(0.0, -sign(distance) * max_offset_shadow, abs(distance/(center.x)))

func follow_mouse(delta: float) -> void:
	if not following_mouse: return
	var mouse_pos: Vector2 = get_global_mouse_position()
	global_position = mouse_pos - (size/2.0)



func _on_gui_input(event: InputEvent) -> void:
	
	
	# Don't compute rotation when moving the card
	if following_mouse: return
	if not event is InputEventMouseMotion: return
	
	# Handles rotation
	# Get local mouse pos
	var mouse_pos: Vector2 = get_local_mouse_position()
	#print("Mouse: ", mouse_pos)
	#print("Card: ", position + size)
	var diff: Vector2 = (position + size) - mouse_pos

	var lerp_val_x: float = remap(mouse_pos.x, 0.0, size.x, 0, 1)
	var lerp_val_y: float = remap(mouse_pos.y, 0.0, size.y, 0, 1)
	#print("Lerp val x: ", lerp_val_x)
	#print("lerp val y: ", lerp_val_y)

	var rot_x: float = rad_to_deg(lerp_angle(-angle_x_max, angle_x_max, lerp_val_x))
	var rot_y: float = rad_to_deg(lerp_angle(angle_y_max, -angle_y_max, lerp_val_y))
	#print("Rot x: ", rot_x)
	#print("Rot y: ", rot_y)
	
	card_texture.material.set_shader_parameter("x_rot", rot_y)
	card_texture.material.set_shader_parameter("y_rot", rot_x)

func _on_mouse_entered() -> void:
	if tween_hover and tween_hover.is_running():
		tween_hover.kill()
	tween_hover = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween_hover.tween_property(self, "scale", Vector2(1.2, 1.2), 0.5)

func _on_mouse_exited() -> void:
	# Reset rotation
	if tween_rot and tween_rot.is_running():
		tween_rot.kill()
	tween_rot = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK).set_parallel(true)
	tween_rot.tween_property(card_texture.material, "shader_parameter/x_rot", 0.0, 0.5)
	tween_rot.tween_property(card_texture.material, "shader_parameter/y_rot", 0.0, 0.5)
	
	# Reset scale
	if tween_hover and tween_hover.is_running():
		tween_hover.kill()
	tween_hover = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween_hover.tween_property(self, "scale", Vector2.ONE, 0.55)



##ITEMEEEEEEES

var numitem = 0

func get_random_number():
	numitem = randi() % 9 + 1 #36
	
	
func selectItem():
	get_random_number()
	print(numitem)
	#da textura a la carta
	if numitem == 1:
		$CardTexture.texture = load("res://sprites/Items/godpower.png")
	elif numitem == 2:
		$CardTexture.texture = load("res://sprites/Items/inherticance.png")
	elif numitem == 3:
		$CardTexture.texture = load("res://sprites/Items/nuke.png")
	elif numitem == 4:
		$CardTexture.texture = load("res://sprites/Items/paticle acc.png")
	elif numitem == 5:
		$CardTexture.texture = load("res://sprites/Items/pi.png")
	elif numitem == 6: 
		$CardTexture.texture = load("res://sprites/Items/piamid.png")
	elif numitem == 7:
		$CardTexture.texture = load("res://sprites/Items/32.png")
	elif numitem == 8:
		$CardTexture.texture = load("res://sprites/Items/52.png")
	elif numitem == 9:
		$CardTexture.texture = load("res://sprites/Items/17.png")
	
func _on_pressed():
	if Global.itemcasinoselected == true:
		self.disabled
	if Global.itemcasinoselected == false:
		if numitem == 1: #freshteeth
			Item.god()
		if numitem == 2: #toastburnt
			Item.herencia()
		if numitem == 3: #toastburnt
			Item.nuke()
		if numitem == 4: #toastburnt
			Item.partice()
		if numitem == 5: #toastburnt
			Item.pi()
		if numitem == 6: #toastburnt
			Item.pyramid()
		if numitem == 7: #toastburnt
			Item.flameth()
		if numitem == 8: #toastburnt
			Item.leghero()
		if numitem == 9: #toastburnt
			Item.magiclemon()

		Global.itemcasinoselected = true
		destroy()
		$"../AnimationPlayer".play("fadeout")
		await get_tree().create_timer(3).timeout
		queue_free()

