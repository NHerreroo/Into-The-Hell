extends Node

var num1 = 0

func random():
	num1 = randi() % 4 + 1
	
func randomstat():
	random()
	if num1 == 1:
		Global.velocidad += 60
	elif num1 == 2:
		Global.cadencia -= 0.025
	elif num1 == 3:
		Global.daño += 30
	elif num1 == 4:
		Global.velocidadbala -= 100
	

func randomstatnegative():
	random()
	if num1 == 1:
		Global.velocidad -= 60
	elif num1 == 2:
		Global.cadencia += 0.025
	elif num1 == 3:
		Global.daño -= 30
	elif num1 == 4:
		Global.velocidadbala += 100

func FreshTheeth():
	Global.velocidad += 100
	
func burntToast():
	Global.cadencia -= 0.015

func bullying():
	Global.daño += 35

func ironlung():
	Global.velocidad += 50
	if Global.health > 1:
		Global.health -= 2
		
func monocle():
	Global.bullet_sizeX += 0.3
	Global.bullet_sizeY += 0.3
	Global.velocidadbala -= 20
	

func overload():
	Global.cadencia -= 0.025
	Global.health += 2

var active = false
func sexpistol():
	while true:
		await get_tree().create_timer(0.0001).timeout
		if Global.current_bullets == 4 && active == false:
			Global.daño += 400
			active = true
		elif Global.current_bullets == 3 && active == true:
			active = false
			Global.daño -= 400
			
func nerdge():
	Global.velocidadbala += 130

func onrepeat():
	Global.max_bulelts += 5
	Global.recarga -= 0.3


var antigravv = false
func antigrav():
	Global.velocidadbala = 0
	antigravv = true


func asrtofood():
	Global.bullet_sizeX += 0.15
	Global.bullet_sizeY += 0.15
	Global.health -= 2
	Global.velocidadbala -= 150

func bean():
	Global.health -= 4

func magicbean():
	Global.health -= 4
	Global.cadencia -= 0.018
	
func magiclemon():
	Global.piercing = true
	
func maxglove():
	Global.bullet_sizeX += 0.15
	Global.bullet_sizeY += 0.15
	Global.daño += 20

func pirlete():
	randomstat()
	randomstatnegative()
	
func bigbangbabby():
	Global.bullet_sizeX += 0.18
	Global.bullet_sizeY += 0.18
	Global.daño += 20
	Global.velocidadbala -= 100

func reboot():
	Global.recarga -= 0.35

func redhotchill():
	Global.daño += 20
	Global.cadencia -= 0.018
	Global.velocidad += 35
	
func ajo():
	Global.cadencia -= 0.022

func bigcrunch():
	Global.number_of_floor = 1
	get_tree().change_scene_to_file("res://scenes/Maps/lobby.tscn")
	
func sandwichvida():
	Global.cadencia -= 0.018
	Global.health -= 5
	
func canicas():
	Global.cadencia -= 0.15
	
func coffe():
	Global.velocidad += 100
	Global.cadencia -= 0.028

func relarena():
	Global.recarga -= 0.35
	
func toolbox():
	Global.recarga -= 0.7
	
func ench():
	Global.cadencia -= 0.025
	Global.max_bulelts += 10

func java():
	Global.health += 3
	Global.cadencia -= 0.035
	
func flameth():
	Global.cadencia -= 0.42
	Global.daño -= 40
	Global.max_bulelts += 10

func misisipi():
	Global.health -= 4
	Global.velocidad += 150

func sandwichdeadth():
	Global.health += 3
	Global.daño += 20

func themoon():
	Global.cadencia -= 0.035
	Global.bullet_sizeX -= 0.10
	Global.bullet_sizeY -= 0.10

func thesun():
	Global.bullet_sizeX += 0.20
	Global.bullet_sizeY += 0.20
	Global.daño += 20
	

func skibidiki():
	Global.cadencia -= 0.025

func brokenruler():
	Global.cadencia -= 0.015
	Global.velocidadbala -= 100

func fortunecookie():
	randomstat()
	
func cannon():
	Global.velocidadbala -= 170
	Global.bullet_sizeX += 0.22
	Global.bullet_sizeY += 0.22

func thepower():
	Global.cadencia -= 0.015
	Global.daño += 20

func atomic():
	Global.cadencia -= 0.025
	Global.bullet_sizeX -= 0.5
	Global.bullet_sizeY -= 0.5

func beefbu():
	Global.daño += 35

func cyclops():
	Global.bullet_sizeX += 0.25
	Global.bullet_sizeY += 0.25

func tecnoblade():
	Global.daño += 20
	Global.velocidad += 150
	

func jitsu():
	Global.cadencia -= 0.015
	Global.max_bulelts += 20

func spicychuks():
	Global.cadencia -= 0.015
	Global.velocidadbala -= 100
	
func hellish():
	Global.daño += 35
	
func terracota():
	Global.daño += 25
	Global.health -= 4
	

func leghero():
	Global.daño += 25
	Global.health -= 3
	Global.cadencia -= 0.015

func spiderdonut():
	Global.cadencia -= 0.015
	Global.velocidad += 150

func momscard():
	Global.monedas += randi() % 30 + 1 

func socialcredit():
	Global.monedas += randi() % 30 + 1 
	Global.cadencia -= 0.015
	
func mutation():
	randomstat()

func normalcan():
	Global.velocidadbala -= 150
	Global.velocidad += 170
	
func oil():
	Global.velocidad += 170
	Global.recarga -= 0.3
	
func bug():
	Global.max_bulelts += randi() % 30 + 1 
	
func stonks():
	var monedas = randi() % 30 + 1 
	var opcion = randi() % 2 +1
	if opcion == 1:
		Global.monedas += monedas
	else:
		Global.monedas -= monedas
		
		
		
		
		
func god():
	Global.daño += 60
	
func herencia():
	Global.monedas += 40

func nuke():
	Global.daño += 50

func pi():
	Global.max_bulelts = 999999999999999999

func partice():
	Global.cadencia -= 0.20

func pyramid():
	Global.cadencia -= 0.15

func _process(delta):
	if antigravv == true:
		Global.velocidadbala = 0
	if Global.daño < 10:
		Global.daño = 10
	if Global.health < 1:
		Global.health = 1
	if Global.bullet_sizeX < 0.30:
		Global.bullet_sizeX = 0.30
		Global.bullet_sizeY = 0.30
	if Global.velocidad < 30:
		Global.velocidad = 30
	if Global.velocidadbala < 0:
		Global.velocidadbala = 0
	if Global.monedas <= 0:
		Global.monedas = 0
