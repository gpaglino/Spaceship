extends Area2D

class_name Nave

const ROCORRIDO_BALA = preload("res://escenas/Balas.tscn") 
var explosion_scena = preload("res://escenas/Explosion.tscn")



var speed = 200  # Velocidad del movimiento en píxeles por segundo
var velocity = Vector2.ZERO  # Vector de movimiento
var time := 0.0  # Temporizador para disparos
var fire : bool




func _process(delta):
	# Reinicia el vector de movimiento cada fotograma
	velocity = Vector2.ZERO

	# Detecta las entradas del teclado
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1

	# Normalizar el vector si hay movimiento diagonal
	if velocity.length() > 0:
		velocity = velocity.normalized()

	# Mover el área
	position += velocity * speed * delta

	# Llamar a la función que limita el movimiento dentro de la pantalla
	_keep_within_screen()
	
	# Función para disparar 
	fire_bullets(delta)

# Función para mantener el Sprite dentro de los límites de la pantalla
func _keep_within_screen():
	var screen_size = get_viewport_rect().size  # Obtener el tamaño de la pantalla

	# Obtener el tamaño del CollisionShape2D
	var shape = $Nave.shape
	var area_size = Vector2.ZERO
	
	match shape:
		CapsuleShape2D:
			area_size = Vector2(shape.radius * 2, shape.height)  # Radio * 2 para el ancho, altura del capsule
		RectangleShape2D:
			area_size = shape.extents * 2  # Extents * 2 para obtener el ancho y alto
		CircleShape2D:
			area_size = Vector2(shape.radius * 2, shape.radius * 2)  # Radio * 2 para el ancho y alto
		# Agrega más tipos de formas si es necesario
		_:
			area_size = Vector2(0, 0)  # Por defecto, un área de 0

	# Limitar el movimiento en el eje X (horizontal)
	if position.x < area_size.x / 2:
		position.x = area_size.x / 2
	elif position.x > screen_size.x - area_size.x / 2:
		position.x = screen_size.x - area_size.x / 2

	# Limitar el movimiento en el eje Y (vertical)
	if position.y < area_size.y / 2:
		position.y = area_size.y / 2
	elif position.y > screen_size.y - area_size.y / 2:
		position.y = screen_size.y - area_size.y / 2

func fire_bullets(delta):
	time += delta
	fire = Input.is_action_just_pressed("ui_accept")  # Cambia esta línea si necesitas otro input
	
	if fire and time >= 0.2:
		shoot_bullet(Balas.DireccionBala.TOP)  # Dispara hacia arriba
		time = 0.0

	# Detectar disparos hacia arriba y abajo
	if Input.is_action_just_pressed("ui_select"):  # Espacio
		shoot_bullet(Balas.DireccionBala.TOP)  # Disparar hacia arriba
	elif Input.is_action_just_pressed("ui_cancel"):  # Control
		shoot_bullet(Balas.DireccionBala.BOTTOM)  # Disparar hacia abajo

func shoot_bullet(direction):
	var inst_bullet = ROCORRIDO_BALA.instantiate()  # Instancia la bala
	get_parent().add_child(inst_bullet)  # Agrega la bala al nodo padre
	inst_bullet.direction = direction  # Establece la dirección de la bala
	inst_bullet.global_position = position  # Establece la posición inicial de la bala
	
	#SE REPRODUCE EL SONIDO DE DISPARO POR CADA LLAMADA A ESTA FUNCION
	$SonidoDisparo.play()



func spawn_explosion():
	var explosion = explosion_scena.instantiate()  # Instanciar la escena de la explosión
	explosion.position = position  # Colocamos la explosión en la misma posición del meteorito
	get_parent().add_child(explosion)  # Añadimos la explosión a la escena
		
		# Reproducir la animación de explosión
	var animation_player = explosion.get_node("AnimationPlayer")
	if animation_player:
		animation_player.play("explosion")  



func _on_area_entered(area: Area2D) -> void:
	if area.name == "Meteorito":
		spawn_explosion()
		queue_free()  # Eliminamos la nave

	
