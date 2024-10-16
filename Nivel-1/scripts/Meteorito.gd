extends Area2D

class_name Meteorito

# cargamos la escena de la explosión
# @onready var animacionExplosion = $"../Explosion"
var speed = 25

# rotación del meteorito
var rotation_speed = randf_range(0.05, 0.3)  # velocidad de rotación aleatoria

# llamado cuando el nodo entra en el árbol de la escena por primera vez
func _ready() -> void:
	var scal = randf_range(0.6, 1.1)  # obtener una escala aleatoria entre 0.6 y 1.1
	scale = Vector2(scal, scal)  # asignar la misma escala a ambos componentes
	
	# ajustar la vida y la velocidad según la escala
	if scal >= 1.0:
		speed = 100  # velocidad ajustada para escala mayor o igual a 1
	elif scal < 0.9:
		speed = 50  # velocidad ajustada para escala menor a 0.9
	elif scal <= 0.7:
		speed = 25  # velocidad ajustada para escala menor o igual a 0.7

# llamado cada frame. 'delta' es el tiempo transcurrido desde el frame anterior
func _process(delta: float) -> void:
	position += Vector2(0, speed * delta)  # mover el meteoro hacia abajo
	# rotar el meteorito sobre su eje
	rotation += rotation_speed * delta

func destroy():
	# cargar la escena de la explosión
	var explosion_scene = preload("res://Nivel-1/escenas/Explosion.tscn")
	var explosion_instance = explosion_scene.instantiate()  # instancia la explosión

	# colocar la explosión en la posición actual del meteorito
	explosion_instance.global_position = global_position

	# añadir la explosión a la jerarquía de nodos
	get_parent().add_child(explosion_instance)

	# buscar el nodo explosion que es un AnimatedSprite2D usando la ruta proporcionada
	var animated_sprite = explosion_instance.get_node_or_null("../Explosion")
	
	animated_sprite.play("explosion")  # reproducir la animación "explosion"
	print("error: no se encontró el nodo Explosion en la explosión")

	# eliminar el meteorito
	queue_free()
