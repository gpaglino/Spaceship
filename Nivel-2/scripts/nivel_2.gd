extends Node2D

const enemigos = preload("res://Nivel-2/escenas/enemigos.tscn")
const GAME_OVER = preload("res://Nivel-1/escenas/GameOver.tscn")

func _ready():
	crear_enemigos()
	
func crear_enemigos():
	var filas = 4
	var columnas = 4
	var espaciamiento_x = 150  # Distancia entre columnas
	var espaciamiento_y = 60  # Distancia entre filas
	var posicion_inicial_y = 10  # Ajusta este valor para subir o bajar las naves
	
	
	for fila in range(filas):
		for columna in range(columnas):
			var enemy = enemigos.instantiate()
			enemy.position = Vector2(100 + columna * espaciamiento_x, posicion_inicial_y + fila * espaciamiento_y)  # Sube la posición inicial
			add_child(enemy)
			
func _perder_partida() -> void:	
	# Cambia a la escena de Game Over de forma diferida
	call_deferred("cambiar_a_game_over")

func cambiar_a_game_over() -> void:
	# Detener el Timer (si tienes uno en la escena actual)
	var timer = $SpawnEnemigos  # Asegúrate de que el nodo Timer está en la escena actual
	if timer:
		timer.stop()  # Detener el Timer

	# Instancia la escena de Game Over
	var game_over_scene = GAME_OVER.instantiate()
	
	# Comprueba que la escena se ha cargado correctamente
	if game_over_scene:
		# Añadir la escena de Game Over al árbol de escenas
		get_tree().root.add_child(game_over_scene)
		
		# Eliminar la escena actual del árbol de escenas
		get_tree().current_scene.queue_free()
	else:
		print("Error: No se pudo instanciar la escena de Game Over")
	
	
func _process(delta: float) -> void:
	pass
