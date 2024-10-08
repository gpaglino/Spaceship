extends Area2D

class_name Nave

const ROCORRIDO_BALA = preload("res://Nivel-1/escenas/Balas.tscn") 
var explosion_escena = preload("res://Nivel-1/escenas/Explosion.tscn")
const Balas = preload("res://Nivel-1/scripts/Balas.gd")


var speed = 350  # Velocidad del movimiento en píxeles por segundo
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
	var fire = Input.is_action_just_pressed("ui_accept")  # Detectar el disparo

	# Control de disparo hacia arriba con un intervalo de tiempo
	if fire and time >= 0.2:
		shoot_bullet(Balas.DireccionBala.TOP)  # Acceder a la dirección de la bala
		time = 0.0  # Reiniciar el temporizador

# Detectar disparos hacia arriba o hacia abajo con otros inputs
	if Input.is_action_just_pressed("ui_select"):  # Disparar hacia arriba
		shoot_bullet(Balas.DireccionBala.TOP)
	elif Input.is_action_just_pressed("ui_cancel"):  # Disparar hacia abajo
		shoot_bullet(Balas.DireccionBala.BOTTOM)
	
	
	#FUNCION DE DISPARAR BALA
func shoot_bullet(direction):
	var inst_bullet = ROCORRIDO_BALA.instantiate()  # Instancia la bala
	get_parent().add_child(inst_bullet)  # Agrega la bala al nodo padre
	inst_bullet.direction = direction  # Establece la dirección de la bala
	
	# Obtén la posición global del Marker2D llamado "SpawnearBala" de la Nave
	var spawner_position = $SpawnearBala.global_position
	inst_bullet.global_position = spawner_position  # Establece la posición inicial de la bala
	
	# SE REPRODUCE EL SONIDO DE DISPARO POR CADA LLAMADA A ESTA FUNCION
	$SonidoDisparo.play()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Meteoros"):
		# Usa call_deferred para posponer la destrucción del meteoro
		area.call_deferred("queue_free")

		# Usa call_deferred para limpiar los meteoritos y cambiar la escena
		get_parent()._perder_partida()
	
