extends Area2D


var bullet_scene = preload("res://Nivel-2/escenas/Balas.tscn")
var speed = 100  # Velocidad de movimiento
var direction = 1  # Dirección inicial (1 para la derecha, -1 para la izquierda)
var boundary_left = 10  # Límite izquierdo
var boundary_right = 1000  # Límite derecho (ajusta según el tamaño de la pantalla)

func _ready():
	$Timer.start()
	
func _process(delta):
	position.x += speed * delta * direction  # Mueve horizontalmente
	check_boundaries()

func check_boundaries():
	if position.x <= boundary_left:
		direction = 1  # Cambiar dirección a la derecha
	elif position.x >= boundary_right:
		direction = -1  # Cambiar dirección a la izquierda

func _on_spawn_enemigos_timeout() -> void:
	disparar()
	pass # Replace with function body.

func disparar():
	var bullet = bullet_scene.instance()
	bullet.position = $Position2D.global_position
	get_parent().add_child(bullet)
	bullet.move_local_y(10)  # Mueve la bala hacia abajo
	
