extends Camera2D

const MAX_DISTANCE = 100

var target_distance = 0
var center_pos = position

func _process(delta):
	if Global.camera == true:
		self.enabled = true
	if Global.camera == false:
		self.enabled = false
		
	var direction = center_pos.direction_to(get_local_mouse_position())
	var target_pos = center_pos + direction * target_distance
	
	target_pos = target_pos.clamp(
		center_pos - Vector2(MAX_DISTANCE, MAX_DISTANCE),
		center_pos + Vector2(MAX_DISTANCE, MAX_DISTANCE)
		
	)
	
#	if Global.is_pulso_ritmo == true:
#		$AnimationPlayer.play("cam_zoom")
	
	position = target_pos
	
func _input(event):
	if event is InputEventMouseMotion:
		target_distance = center_pos.distance_to(get_local_mouse_position()) /2 
