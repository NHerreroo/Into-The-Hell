extends Sprite2D

var fly = preload("res://scenes/Enemies/fly.tscn")
var slime = preload("res://scenes/Enemies/slime.tscn")
var mule = preload("res://scenes/Enemies/mole.tscn")
var fat = preload("res://scenes/Enemies/fat.tscn")
var flybomb = preload("res://scenes/Enemies/flybomb.tscn")
var thrower = preload("res://scenes/Enemies/thrower.tscn")

var num1 = 0
var num2 = 0

# Obtén la posición del jugador en el momento de la instanciación
var player_position = Vector2.ZERO

func get_random_pos():
	while true:
		num1 = randi_range(-257, 606)
		num2 = randi_range(-76, 385)
		var potential_pos = Vector2(num1, num2)
		if potential_pos.distance_to(player_position) >= 200:
			break

# enemigos disponibles:
func flyInstance():
	var enemigo = fly.instantiate()
	get_random_pos()
	enemigo.position = Vector2(num1, num2)
	get_tree().root.add_child(enemigo)	
	
func slimeInstance():
	var enemigo = slime.instantiate()
	get_random_pos()
	enemigo.position = Vector2(num1, num2)
	get_tree().root.add_child(enemigo)
	
func muleInstance():
	var enemigo = mule.instantiate()
	get_random_pos()
	enemigo.position = Vector2(num1, num2)
	get_tree().root.add_child(enemigo)
	
func fatInstance():
	var enemigo = fat.instantiate()
	get_random_pos()
	enemigo.position = Vector2(num1, num2)
	get_tree().root.add_child(enemigo)
	
func flybombInstance():
	var enemigo = flybomb.instantiate()
	get_random_pos()
	enemigo.position = Vector2(num1, num2)
	get_tree().root.add_child(enemigo)	

func ThrowerInstance():
	var enemigo = thrower.instantiate()
	get_random_pos()
	enemigo.position = Vector2(num1, num2)
	get_tree().root.add_child(enemigo)	

# selecciona el enemigo aleatorio
func random_enemy():
	var enemigo = 0
	enemigo = randi() % 6 + 1
	print(enemigo)
	if enemigo == 1:
		slimeInstance()
	if enemigo == 2:
		flyInstance()
	if enemigo == 3:
		muleInstance()
	if enemigo == 4:
		fatInstance()
	if enemigo == 5:
		flybombInstance()
	if enemigo == 6:
		ThrowerInstance()
		
func _ready():
	Global.is_playing = true
	player_position = $"../Player".position
	await get_tree().create_timer(1).timeout
	while Global.is_playing:
		await get_tree().create_timer(0.000001).timeout
		if Global.is_pulso_ritmo:
			Global.enemies_on_screen += 1
			random_enemy()
