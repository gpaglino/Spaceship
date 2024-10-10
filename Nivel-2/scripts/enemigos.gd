extends Area2D


var bullet_scene = preload("res://Nivel-1/escenas/Balas.tscn")

var speed = 100  # Velocidad de movimiento horizontal
var direction = 1  # Dirección inicial (1 para derecha, -1 para izquierda)
var boundary_left = 10  # Límite izquierdo
var boundary_right = 1000  # Límite derecho
var random_shoot_chance = 0.005  # Probabilidad de disparar por frame (ajusta este valor)

enum DireccionBala {
	TOP,
	BOTTOM
}

func _ready():
	$Timer.start()

func _process(delta):
	# Movimiento horizontal de la nave
	position.x += speed * delta * direction
	check_boundaries()

	# Probabilidad de disparar en cada frame
	if randf() < random_shoot_chance:
		disparar()

func check_boundaries():
	# Cambia la dirección al llegar a los límites
	if position.x <= boundary_left:
		direction = 1  # Cambiar dirección a la derecha
	elif position.x >= boundary_right:
		direction = -1  # Cambiar dirección a la izquierda

func disparar():
	var bullet = bullet_scene.instantiate()
	bullet.position = $Marker2D.global_position  # Ajusta la posición de la bala
	bullet.direction = DireccionBala.BOTTOM  # Establece la dirección de la bala hacia abajo
	get_parent().add_child(bullet)
	
func destroy_enemigo():
	# Cargar la escena de la explosión
	var explosion_scene = preload("res://Nivel-1/escenas/Explosion.tscn")
	var explosion_instance = explosion_scene.instantiate()  # Instancia la explosión

	# Colocar la explosión en la posición actual del enemigo
	explosion_instance.global_position = global_position

	# Añadir la explosión a la jerarquía de nodos
	get_parent().add_child(explosion_instance)

	# Buscar el nodo Explosion que es un AnimatedSprite2D usando la ruta proporcionada
	var animated_sprite = explosion_instance.get_node_or_null("Explosion")
	
	
	animated_sprite.play("explosion")  # Reproducir la animación "explosion"
	print("Error: No se encontró el nodo Explosion en la explosión")

	# Eliminar el meteorito
	queue_free()
