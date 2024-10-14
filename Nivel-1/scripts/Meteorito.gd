extends Area2D

class_name Meteorito

# Cargamos la escena de la explosión
#@onready var animacionExplosion = $"../Explosion"
var speed = 25

#rotacion de el meteorito
var rotation_speed = randf_range(0.05, 0.3)  # Velocidad de rotación aleatoria

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var scal = randf_range(0.7, 1.2)  # Obtener una escala aleatoria entre 0.5 y 0.9
	scale = Vector2(scal, scal)  # Asignar la misma escala a ambos componentes
	

	# Ajustar la vida y la velocidad según la escala
	if scal >= 1.0:
		speed = 100  # Reducido de 500 a 400
	elif scal < 0.9:
		speed = 50  # Reducido de 600 a 500
	elif scal <= 0.7:
		speed = 25  # Reducido de 750 a 600

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += Vector2(0, speed * delta)  # Mover el meteoro hacia abajo
		# Rotar el meteorito sobre su eje
	rotation += rotation_speed * delta

func destroy():
	# Cargar la escena de la explosión
	var explosion_scene = preload("res://Nivel-1/escenas/Explosion.tscn")
	var explosion_instance = explosion_scene.instantiate()  # Instancia la explosión

	# Colocar la explosión en la posición actual del meteorito
	explosion_instance.global_position = global_position

	# Añadir la explosión a la jerarquía de nodos
	get_parent().add_child(explosion_instance)

	# Buscar el nodo Explosion que es un AnimatedSprite2D usando la ruta proporcionada
	var animated_sprite = explosion_instance.get_node_or_null("../Explosion")
	
	animated_sprite.play("explosion")  # Reproducir la animación "explosion"
	print("Error: No se encontró el nodo Explosion en la explosión")

	# Eliminar el meteorito
	queue_free()
