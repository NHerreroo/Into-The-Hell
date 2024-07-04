extends Label

var music = preload("res://scenes/music_controller.tscn")
var item = preload("res://scenes/Items/select_item.tscn")
var minutes = 1
var seconds = 30 
# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.time_scale = 1
	Global.is_playing = true
	
	var musicsound = music.instantiate()
	get_tree().root.add_child(musicsound)
	await get_tree().create_timer(5).timeout
	while Global.is_playing == true:
		await get_tree().create_timer(1).timeout
		if minutes == 0 and seconds == 0:
			Global.is_playing = false
			break
		if seconds <= 0:
			seconds = 59
			minutes -= 1
		seconds -= 1
	while true:
		await get_tree().create_timer(1).timeout
		if Global.enemies_on_screen == 0:
			var itemSelector = item.instantiate()
			get_tree().root.add_child(itemSelector)
			break

func _process(delta):
	self.text = str(minutes, ":", seconds)
	if minutes == 0 and seconds == 0:
		self.text = str("TIMES UP")
		if Global.itemselected == true:
			self.visible = false
	if Global.itemselected == false:
		self.visible = true
		
