extends Node

var is_pulso_ritmo = false
var tempo = 1


#variables para incremenatr en parida
var daño = 1150.0
var velocidad = 250.0
var cadencia = 0.500
var velocidadbala = 900
var coldowndash = 0
var bullet_sizeX = 0.55
var bullet_sizeY = 0.55
var recarga = 2
var piercing = false

var shop = false
var max_bulelts = 10
var current_bullets = 10

var itemselected = false
var itemcasino = false
var itemcasinoselected = false
var nodamage = false

var run_start = false
var is_playing = false
var number_of_floor = 1

var camera = true
var enemies_on_screen = 0
var bossdefeat = false

var monedas = 0
var health = 1
var death = false
		
#func _ready():
	#Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN

func _process(delta):
	if Input.is_action_pressed("exit"):
		get_tree().quit()
	health = health
	bullet_sizeX = bullet_sizeX
	bullet_sizeY = bullet_sizeY
	if max_bulelts < 5:
		max_bulelts = 5
	

