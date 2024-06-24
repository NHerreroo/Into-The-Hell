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
	numitem = randi() % 60 + 1 #36
	
	
func selectItem():
	get_random_number()
	print(numitem)
	#da textura a la carta
	$CardTexture.texture = load("res://sprites/Items/" + str(numitem) + ".png")
	
func _on_pressed():
	if Global.itemselected == true:
		self.disabled
	if Global.itemselected == false:
		if numitem == 1: #freshteeth
			Item.FreshTheeth()
		if numitem == 2: #toastburnt
			Item.burntToast()
		if numitem == 3: #toastburnt
			Item.bullying()
		if numitem == 4: #toastburnt
			Item.ironlung()
		if numitem == 5: #toastburnt
			Item.monocle()
		if numitem == 6: #toastburnt
			Item.overload()
		if numitem == 7: #toastburnt
			Item.sexpistol()
		if numitem == 8: #toastburnt
			Item.nerdge()
		if numitem == 9: #toastburnt
			Item.onrepeat()
		if numitem == 10: #toastburnt
			Item.onrepeat()
		if numitem == 11: #toastburnt
			Item.onrepeat()
		if numitem == 12: #toastburnt
			Item.onrepeat()
		if numitem == 13: #toastburnt
			Item.antigrav()
		if numitem == 14: #toastburnt
			Item.bean()
		if numitem == 15: #toastburnt
			Item.bigbangbabby()
		if numitem == 16: #toastburnt
			Item.magicbean()
		if numitem == 17: #toastburnt
			Item.magiclemon()
		if numitem == 18: #toastburnt
			Item.maxglove()
		if numitem == 19: #toastburnt
			Item.pirlete()
		if numitem == 20: #toastburnt
			Item.reboot()
		if numitem == 21: #toastburnt
			Item.redhotchill()
		if numitem == 22: #toastburnt
			Item.relarena()
		if numitem == 23: #toastburnt
			Item.toolbox()
		if numitem == 24: #toastburnt
			Item.asrtofood()
		if numitem == 25: #toastburnt
			Item.ajo()
		if numitem == 26: #toastburnt
			Item.bigcrunch()
		if numitem == 27: #toastburnt
			Item.sandwichvida()
		if numitem == 28: #toastburnt
			Item.canicas()
		if numitem == 29: #toastburnt
			Item.coffe()
		if numitem == 30: #toastburnt
			Item.ench()
		if numitem == 31: #toastburnt
			Item.java()
		if numitem == 32: #toastburnt
			Item.flameth()
		if numitem == 33: #toastburnt
			Item.misisipi()
		if numitem == 34: #toastburnt
			Item.sandwichdeadth()
		if numitem == 35: #toastburnt
			Item.themoon()
		if numitem == 36: #toastburnt
			Item.thesun()
		if numitem == 37: #toastburnt
			Item.onrepeat()
		if numitem == 38: #toastburnt
			Item.onrepeat()
		if numitem == 39: #toastburnt
			Item.skibidiki()
		if numitem == 40: #toastburnt
			Item.brokenruler()
		if numitem == 41: #toastburnt
			Item.fortunecookie()
		if numitem == 42: #toastburnt
			Item.cannon()
		if numitem == 43: #toastburnt
			Item.thepower()
		if numitem == 44: #toastburnt
			Item.atomic()
		if numitem == 45: #toastburnt
			Item.beefbu()
		if numitem == 46: #toastburnt
			Item.cyclops()
		if numitem == 47: #toastburnt
			Item.tecnoblade()
		if numitem == 48: #toastburnt
			Item.jitsu()
		if numitem == 49: #toastburnt
			Item.spicychuks()
		if numitem == 50: #toastburnt
			Item.hellish()
		if numitem == 51: #toastburnt
			Item.terracota()
		if numitem == 52: #toastburnt
			Item.leghero()
		if numitem == 53: #toastburnt
			Item.spiderdonut()
		if numitem == 54: #toastburnt
			Item.momscard()
		if numitem == 55: #toastburnt
			Item.socialcredit()
		if numitem == 56: #toastburnt
			Item.mutation()
		if numitem == 57: #toastburnt
			Item.normalcan()
		if numitem == 58: #toastburnt
			Item.oil()
		if numitem == 59: #toastburnt
			Item.bug()
		if numitem == 60: #toastburnt
			Item.stonks()
			
		Global.itemselected = true
		destroy()
		if 	Global.shop == false:
			await get_tree().create_timer(1).timeout
			var nextfloor = transitionfloor.instantiate()
			get_tree().root.add_child(nextfloor)
