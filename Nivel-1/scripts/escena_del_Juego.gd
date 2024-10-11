extends Node2D

var Meteoro = preload("res://Nivel-1/escenas/Meteorito.tscn")
#var Bala = preload("res://Nivel-1/escenas/Balas.tscn")
#var Nave = preload("res://Nivel-1/escenas/Nave.tscn")
#var Explosion = preload("res://Nivel-1/escenas/Explosion.tscn")
const CINEMATICA_N_1 = preload("res://Nivel-1/escenas/cinematicaN1.tscn")
@onready var timer_label: Label = $TimerLabel
@onready var game_timer: Timer = $gameTimer
@onready var vida1: Sprite2D = $Vidas/vida1
@onready var vida2: Sprite2D = $Vidas/vida2
@onready var vida3: Sprite2D = $Vidas/vida3



# Tiempo máximo de juego 
var time_left = 60

# Vidas iniciales
var vidas = 3  

func _ready() -> void:
	
	limpiar_meteoritos()
	limpiar_enemigos()
	
	# Iniciar el temporizador
	game_timer.start()

	# Configurar el tiempo inicial en el Label
	timer_label.text = str(time_left)
	
	#borro la cinematica cuado inica el juego
	_borrarCinematica()

	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

#Funcion para spawnear los meteoros
func _on_spawn_meteoro_timeout() -> void:
	var meteoro_count = 2  # Número de meteoritos a spawn

	for i in range(meteoro_count):
		var meteoro = Meteoro.instantiate()
		meteoro.add_to_group("Meteoros")
# Generar una posición aleatoria en la parte superior de la pantall
		var screen_width = get_viewport_rect().size.x
		var random_x = randi_range(0, int(screen_width))  # Posición aleatoria en el eje X
		meteoro.position = Vector2(random_x, -50)  # Aparece fuera de la pantalla, por encima

		# Añadir el meteoro a la escena
		get_parent().add_child(meteoro)
		
		
func limpiar_meteoritos():
	for meteoro in get_tree().get_nodes_in_group("Meteoros"):
		meteoro.queue_free()
func limpiar_enemigos():
	for meteoro in get_tree().get_nodes_in_group("Enemigos"):
		meteoro.queue_free()

		
#FUNCION PARA EL CONTADOR A 0
func _on_game_timer_timeout():
	# Restar un segundo del tiempo restante
	time_left -= 1
	timer_label.text = str(time_left)

	# Verificar si el tiempo llegó a cero
	if time_left <= 0:
		# Detener el Timer para que no siga
		game_timer.stop()

		_ganar_partida()

func actualizar_vidas():
	# Ocultar los sprites de corazón según la cantidad de vidas restantes
	vida1.visible = vidas > 0
	vida2.visible = vidas > 1
	vida3.visible = vidas > 2

func _borrarCinematica():
		# Verificar si existe la cinemática en el árbol de nodos
	var cinematica_node = get_tree().root.get_node_or_null("Cinematica")  # Cambia "Cinematica" al nombre del nodo de tu cinemática
	# Si existe, eliminarla del árbol
	if cinematica_node:
		cinematica_node.queue_free()

#funcion para ver cuando los meteoritos colisionan con el area de debajo(saturno)
func _on_area_saturno_area_entered(area: Area2D) -> void:
		if area.is_in_group("Meteoros"):
			vidas -= 1  # Reducir las vidas
			actualizar_vidas()  # Llamar a la función para actualizar el HUD

		if vidas <= 0:
			_perder_partida()
			
func _perder_partida() -> void:
	# Usa call_deferred para limpiar los meteoritos después de la física
	call_deferred("limpiar_meteoritos")
	
	# Cambia a la escena de Game Over de forma diferida
	call_deferred("cambiar_a_game_over")
	
func _ganar_partida():
	get_tree().change_scene_to_file("res://Nivel-2/escenas/nivel_2.tscn")	
	

func cambiar_a_game_over() -> void:
	get_tree().change_scene_to_file("res://Nivel-1/escenas/GameOver.tscn")	
	
