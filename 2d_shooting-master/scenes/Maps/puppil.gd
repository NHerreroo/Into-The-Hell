extends Sprite2D

# Factor de interpolación para suavizar el movimiento. Ajusta este valor según sea necesario.
var lerp_factor: float = 0.1
# Distancia máxima permitida desde el punto de anclaje
var max_distance: float = 30.0
# Posición original del sprite
var original_position: Vector2

func _ready():
	# Guardar la posición original del sprite al inicio
	original_position = global_position

func _process(delta):
	# Obtener la posición del ratón global
	var mouse_position = get_global_mouse_position()
	
	# Calcular la dirección y la distancia al ratón
	var direction = (mouse_position - original_position).normalized()
	var distance = original_position.distance_to(mouse_position)
	
	# Limitar la distancia a la distancia máxima permitida
	var clamped_distance = min(distance, max_distance)
	
	# Calcular la nueva posición interpolada
	var target_position = original_position + direction * clamped_distance
	global_position = global_position.lerp(target_position, lerp_factor)
