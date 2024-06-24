extends Control


func _ready():
	$CanvasLayer.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.death == true:
		$CanvasLayer.visible = false
	elif Global.death == false:
		$CanvasLayer.visible = true
	
	#contador vida:	
	$CanvasLayer/Container2/Heart1.play(str(Global.health))
	
	$CanvasLayer/Cadencia_Label.text = str(Global.cadencia)
	$CanvasLayer/Velocidad_lab.text = str(Global.velocidad /10)
	$"CanvasLayer/Daño_label".text = str(Global.daño / 10)
	$CanvasLayer/Velocidad_bala.text = str(Global.velocidadbala/10)
	$CanvasLayer/Sprite2D/money.text = str(Global.monedas)
	$"CanvasLayer/valas max".text = str(Global.max_bulelts)
	$CanvasLayer/balasactuales.text = str(Global.current_bullets)
	$CanvasLayer/Recarga2.text = str(Global.recarga, " /Sec")
	$CanvasLayer/size.text = str(Global.bullet_sizeX)
	if Global.nodamage == true:
		$CanvasLayer/Icongamblin.visible = true
	elif  Global.nodamage == false:
		$CanvasLayer/Icongamblin.visible = false
