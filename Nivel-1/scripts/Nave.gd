extends Area2D

class_name Nave

const RECORRIDO_BALA = preload("res://Nivel-1/escenas/Balas.tscn") 
var explosion_escena = preload("res://Nivel-1/escenas/Explosion.tscn")
const Balas_script = preload("res://Nivel-1/scripts/Balas.gd")

var puede_disparar = true  # bandera para controlar si puede disparar
var speed = 350  # velocidad del movimiento en píxeles por segundo
var velocity = Vector2.ZERO  # vector de movimiento
var time := 0.0  # temporizador para disparos

func _process(delta):
	# Reinicia el vector de movimiento cada fotograma
	velocity = Vector2.ZERO

	# detecta las entradas del teclado
	if Input.is_action_pressed("ui_right"): #flecha derecha
		velocity.x += 1
	if Input.is_action_pressed("ui_left"): #flecha izquierda
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"): #flecha abajo
		velocity.y += 1
	if Input.is_action_pressed("ui_up"): #flecha arriba
		velocity.y -= 1

	# normalizar el vector si hay movimiento diagonal
	if velocity.length() > 0:
		velocity = velocity.normalized()

	# mover el área
	position += velocity * speed * delta

	# llamar a la función que limita el movimiento dentro de la pantalla
	_keep_within_screen()
	
	# función para disparar 
	fire_bullets(delta)

# función para mantener el sprite dentro de los límites de la pantalla
func _keep_within_screen():
	var screen_size = get_viewport_rect().size  # obtiene el tamaño de la pantalla

	# obtiene el tamaño del CollisionShape2D
	var shape = $Nave.shape
	var area_size = Vector2.ZERO
	
	match shape:
		CapsuleShape2D:
			area_size = Vector2(shape.radius * 2, shape.height)  # radio * 2 para el ancho, altura del capsule
		RectangleShape2D:
			area_size = shape.extents * 2  # extents * 2 para obtener el ancho y alto
		CircleShape2D:
			area_size = Vector2(shape.radius * 2, shape.radius * 2)  # radio * 2 para el ancho y alto
		# agrega más tipos de formas si es necesario
		_:
			area_size = Vector2(0, 0)  # por defecto, un área de 0

	# limitar el movimiento en el eje x (horizontal)
	if position.x < area_size.x / 2:
		position.x = area_size.x / 2
	elif position.x > screen_size.x - area_size.x / 2:
		position.x = screen_size.x - area_size.x / 2

	# limitar el movimiento en el eje y (vertical)
	if position.y < area_size.y / 2:
		position.y = area_size.y / 2
	elif position.y > screen_size.y - area_size.y / 2:
		position.y = screen_size.y - area_size.y / 2

func fire_bullets(delta):
	time += delta
	var fire = Input.is_action_just_pressed("ui_accept")  # detectar el disparo

	# control de disparo hacia arriba con un intervalo de tiempo
	if fire and time >= 0.2:
		shoot_bullet(Balas_script.DireccionBala.TOP)  # acceder a la dirección de la bala
		time = 0.0  # reiniciar el temporizador

	# detectar disparos hacia arriba o hacia abajo con otros inputs
	if Input.is_action_just_pressed("ui_select"):  # disparar hacia arriba
		shoot_bullet(Balas_script.DireccionBala.TOP)
	elif Input.is_action_just_pressed("ui_cancel"):  # disparar hacia abajo
		shoot_bullet(Balas_script.DireccionBala.BOTTOM)

# función de disparar bala
func shoot_bullet(direccion):
	if puede_disparar:  # Verifica si puede disparar es true
		var inst_bullet = RECORRIDO_BALA.instantiate()  # instancia la bala
		get_parent().add_child(inst_bullet)  # agrega la bala al nodo padre
		inst_bullet.direction = direccion  # establece la dirección de la bala

		# obtiene la posición global del Marker2D llamado "SpawnearBala" de la nave
		var spawner_position = $SpawnearBala.global_position
		inst_bullet.global_position = spawner_position  # establece la posición inicial de la bala

		# se reproduce el sonido de disparo por cada llamada a esta función
		$SonidoDisparo.play()
	else:
		print("Disparo desactivado")  # mensaje si no se puede disparar

# función para destruir la nave
func destroy_nave():
	# cargar la escena de la explosión
	var explosion_scene = preload("res://Nivel-1/escenas/Explosion.tscn")
	var explosion_instance = explosion_scene.instantiate()  # instancia la explosión

	# colocar la explosión en la posición actual de la nave
	explosion_instance.global_position = global_position

	# añadir la explosión a la jerarquía de nodos
	get_parent().add_child(explosion_instance)

	# buscar el nodo explosion que es un AnimatedSprite2D usando la ruta proporcionada
	var animated_sprite = explosion_instance.get_node_or_null("../Explosion")
	
	animated_sprite.play("explosion")  # reproducir la animación "explosion"
	print("error: no se encontró el nodo Explosion en la explosión")

	# eliminar la nave
	#queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Meteoros"):
		destroy_nave()
		# usar call_deferred para posponer la destrucción del meteoro
		# usar call_deferred para limpiar los meteoritos y cambiar la escena
		get_parent()._perder_partida()
		area.call_deferred("queue_free")
	else:
		if area.is_in_group("Jefe"):
			destroy_nave()
			# usar call_deferred para posponer la destrucción del meteoro
			# usar call_deferred para limpiar los meteoritos y cambiar la escena
			get_parent()._perder_partida()
			area.call_deferred("queue_free")
