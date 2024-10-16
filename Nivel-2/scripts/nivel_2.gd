extends Node2D

const enemigos = preload("res://Nivel-2/escenas/enemigos.tscn")
const GAME_OVER = preload("res://Nivel-1/escenas/GameOver.tscn")
@onready var cinematica_nivel_2: Node2D = $CinematicaNivel2
const CINEMATICA_NIVEL_3 = preload("res://Nivel-3/escenas/CinematicaNivel3.tscn")

func _ready():
	# limpiar meteoritos y crear enemigos al inicio
	limpiar_meteoritos()
	borrarCinematicaN2()
	crear_enemigos()
	
func _process(delta: float) -> void:
	# verificar si se ha ganado la partida en cada frame
	verificar_ganar()

func verificar_ganar():
	# verifica si quedan enemigos en el grupo
	if get_tree().get_nodes_in_group("Enemigos").size() == 0:
		ganar_partida()

func ganar_partida():
	# detener cualquier timer o spawn de enemigos
	var timer = $SpawnEnemigos
	if timer:
		timer.stop()

	# instanciar la cinemática del siguiente nivel
	var cinematica_nivel_3 = CINEMATICA_NIVEL_3.instantiate()
	
	# verificar si se cargó correctamente
	if cinematica_nivel_3:
		get_tree().root.add_child(cinematica_nivel_3)
		get_tree().current_scene.queue_free()
	else:
		print("Error: No se pudo cargar la cinemática del Nivel 3")	
	
func crear_enemigos():
	# definir la cantidad de filas y columnas para los enemigos
	var filas = 4
	var columnas = 5
	var espaciamiento_x = 150  # distancia entre columnas
	var espaciamiento_y = 60  # distancia entre filas
	var posicion_inicial_y = 10  # subir o bajar las naves
	
	# crear enemigos en un arreglo de filas y columnas
	for fila in range(filas):
		for columna in range(columnas):
			var enemy = enemigos.instantiate()
			enemy.position = Vector2(100 + columna * espaciamiento_x, posicion_inicial_y + fila * espaciamiento_y)  # subir la posición inicial
			add_child(enemy)
			
func _perder_partida() -> void:	
	# cambia a la escena de Game Over de forma diferida
	call_deferred("cambiar_a_game_over")

func cambiar_a_game_over() -> void:
	# detener el Timer (si tienes uno en la escena actual)
	var timer = $SpawnEnemigos  # asegúrate de que el nodo Timer está en la escena actual
	if timer:
		timer.stop()  # detener el Timer

	# instancia la escena de Game Over
	var game_over_scene = GAME_OVER.instantiate()
	
	# comprueba que la escena de Game Over se ha cargado correctamente
	if game_over_scene:
		var nivel_origen = get_tree().current_scene.get_scene_file_path()  # obtener la ruta de la escena actual
		game_over_scene.set_nivel_origen(nivel_origen)  # pasar la ruta a la escena de Game Over
		
		# añadir la escena de Game Over al árbol de escenas
		get_tree().root.add_child(game_over_scene)
		
		# eliminar la escena actual del árbol de escenas
		get_tree().current_scene.queue_free()
	else:
		print("Error: No se pudo instanciar la escena de Game Over")

func borrarCinematicaN2():
	# verificar si la cinemática está en el árbol de nodos
	if cinematica_nivel_2:
		cinematica_nivel_2.queue_free()

func limpiar_meteoritos():
	# detener el Timer de spawn de meteoritos 
	var meteorito_timer = $SpawnMeteoro
	if meteorito_timer:
		meteorito_timer.stop()

	# eliminar todos los meteoritos actuales
	for meteorito in get_tree().get_nodes_in_group("Meteoros"):  # si tienes un grupo para los meteoritos
		meteorito.queue_free()
