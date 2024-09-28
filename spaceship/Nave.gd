extends Sprite2D

const ROCORRIDO_BALA = preload("res://escenas/Balas.tscn") 

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

	# Mover el Sprite
	position += velocity * speed * delta

	# Llamar a la función que limita el movimiento dentro de la pantalla
	_keep_within_screen()
	
	# Función para disparar 
	fire_bullets(delta)

# Función para mantener el Sprite dentro de los límites de la pantalla
func _keep_within_screen():
	var screen_size = get_viewport_rect().size  # Obtener el tamaño de la pantalla

	# Obtener el tamaño del Sprite
	var sprite_size = texture.get_size() / 6  # Divide entre 2 porque el origen está centrado

	# Limitar el movimiento en el eje X (horizontal)
	if position.x < sprite_size.x:
		position.x = sprite_size.x
	elif position.x > screen_size.x - sprite_size.x:
		position.x = screen_size.x - sprite_size.x

	# Limitar el movimiento en el eje Y (vertical)
	if position.y < sprite_size.y:
		position.y = sprite_size.y
	elif position.y > screen_size.y - sprite_size.y:
		position.y = screen_size.y - sprite_size.y

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
