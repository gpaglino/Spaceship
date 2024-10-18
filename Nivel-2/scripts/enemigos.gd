extends Area2D

var bullet_scene = preload("res://Nivel-2/escenas/balas_enemigos.tscn")

var speed = 80  # velocidad de movimiento horizontal
var direction = 1  # dirección inicial (1 para derecha, -1 para izquierda)
var boundary_left = 5  # límite izquierdo
var boundary_right = 1150  # límite derecho
var random_shoot_chance = 0.005  # probabilidad de disparar por frame (ajusta este valor)

enum DireccionBala {
	TOP,
	BOTTOM
}

func _ready():
	# añadir el enemigo al grupo de enemigos
	add_to_group("Enemigos")
	$TimerEnemigos.start()  # iniciar el temporizador para los disparos

func _process(delta):
	# movimiento horizontal de la nave
	position.x += speed * delta * direction
	check_boundaries()

	# probabilidad de disparar en cada frame
	if randf() < random_shoot_chance:
		disparar()

func check_boundaries():
	# cambia la dirección al llegar a los límites
	if position.x <= boundary_left:
		direction = 1  # cambiar dirección a la derecha
	elif position.x >= boundary_right:
		direction = -1  # cambiar dirección a la izquierda

func disparar():
	# instanciar la bala y establecer su posición
	var bullet = bullet_scene.instantiate()
	bullet.position = $Marker2D.global_position  # ajustar la posición de la bala
	bullet.direction = DireccionBala.BOTTOM  # establecer la dirección de la bala hacia abajo
	get_parent().add_child(bullet)  # añadir la bala a la jerarquía

func destroy_enemigo():
	# detener cualquier proceso relacionado con el enemigo
	if $TimerEnemigos.is_stopped():
		$TimerEnemigos.stop()  # detener el temporizador que controla los disparos
		
	# cargar la escena de la explosión
	var explosion_scene = preload("res://Nivel-1/escenas/Explosion.tscn")
	var explosion_instance = explosion_scene.instantiate()  # instancia la explosión

	# colocar la explosión en la posición actual del enemigo
	explosion_instance.global_position = global_position

	# añadir la explosión a la jerarquía de nodos
	get_parent().add_child(explosion_instance)

	# buscar el nodo AnimatedSprite2D llamado Explosion directamente en la instancia de explosión
	var animated_sprite = explosion_instance.get_node_or_null("Explosion")

	if animated_sprite:
		animated_sprite.play("explosion")  # reproducir la animación "explosion"
	else:
		print("Error: No se encontró el nodo Explosion en la escena")

	# eliminar el enemigo
	queue_free()
