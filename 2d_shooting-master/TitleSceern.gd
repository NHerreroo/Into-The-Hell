extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	randomtext()
	
	$transition.visible = false
	Engine.time_scale = 1
	Global.health = 1
	Global.death = false
	Global.tempo = 2.5
	Global.daño = 50.0
	Global.velocidad = 250.0
	Global.cadencia = 0.500
	Global.velocidadbala = 900
	Global.coldowndash = 0
	Global.bullet_sizeX = 0.55
	Global.bullet_sizeY = 0.55
	Global.recarga = 2
	Global.piercing = false
	Global.secondphaseboss = false 
	Global.shop = false
	Global.max_bulelts = 10
	Global.current_bullets = 10
	Global.itemselected = false
	Global.itemcasinoselected = false
	Global.nodamage = false

	Global.run_start = false
	Global.is_playing = false
	Global.number_of_floor = 1

	Global.camera = true
	Global.enemies_on_screen = 0
	Global.bossdefeat = false	
	Global.monedas = 0
	Global.health = 1
	Global.death = false


func _on_button_pressed():
	$transition.visible = true
	$AnimationPlayer.play("fadeout")
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://scenes/Maps/lobby.tscn")


func _on_start_2_pressed():
	get_tree().change_scene_to_file("res://scenes/Maps/CreditsCopy.tscn")
	pass

var num = 0
func randnum():
	num = randi() % 8 + 1
	
var text = "Rate this game :D"  
func randomtext():
	$Label3/AnimationPlayer.play("new_animation")
	randnum()
	if num == 1:
		text = "Rate this game :D" 
	elif num == 2:
		text = "This game is fire!!!" 
	elif num == 3:
		text = "Also try my games!" 
	elif num == 4:
		text = "the devil approves this!" 
	elif num == 5:
		text = "secret boss at second run" 
	elif num == 6:
		text = "Items can kill you :( " 
	elif num == 7:
		text = "Follow me :D" 
	elif num == 8:
		text = "Support Indie content" 
	
func _process(delta):
	$Label3.text = text
	$Strak/Label.text = str(Global.streak)
	
	
	
	
	
	
	
