extends Node2D

const Meteoro = preload("res://Nivel-1/escenas/Meteorito.tscn")
const MENU_INICIO = preload("res://Nivel-1/escenas/menu_inicio.tscn")
@onready var cinematica_nivel_3: Node2D = $CinematicaNivel3
@onready var nave: Nave = $Nave


func _ready() -> void:
	call_deferred("borrarCinematicaN3")


func _process(_delta: float) -> void:
	pass
	
func borrarCinematicaN3():
	# verificar si la cinemática está en el árbol de nodos
	if cinematica_nivel_3:
		cinematica_nivel_3.queue_free()

# función para spawnear los meteoros
func _on_spawn_meteoro_timeout() -> void:
	var meteoro_count = 2  # número de meteoritos a spawn

	for i in range(meteoro_count):
		var meteoro = Meteoro.instantiate()
		meteoro.add_to_group("Meteoros")
		# generar una posición aleatoria en la parte superior de la pantalla
		var screen_width = get_viewport_rect().size.x
		var random_x = randi_range(0, int(screen_width))  # posición aleatoria en el eje X
		meteoro.position = Vector2(random_x, -50)  # aparece fuera de la pantalla, por encima
		# añadir el meteoro a la escena
		get_parent().add_child(meteoro)
	
func _perder_partida() -> void:
	# usa call_deferred para limpiar los meteoritos después de la física
	call_deferred("limpiar_meteoritos")
	
	# cambia a la escena de Game Over de forma diferida
	call_deferred("cambiar_a_game_over")		

func limpiar_meteoritos():
	# eliminar todos los meteoritos en el grupo "Meteoros"
	for meteoro in get_tree().get_nodes_in_group("Meteoros"):
		meteoro.queue_free()	
		
func desactivar_disparo_nave():
	if nave:  # comprueba si el nodo se encontró
		nave.puede_disparar = false  # cambia la variable puede_disparar a false
		print("Disparo desactivado.") 
	else:
		print("El nodo 'Nave' no se encontró.")
			
func cambiar_a_game_over() -> void:
	# aquí 'Nivel1', 'Nivel2', 'Nivel3' es el nombre que pasas según el nivel actual
	var game_over_scene = preload("res://Nivel-1/escenas/GameOver.tscn").instantiate()
	
	# comprueba que la escena de Game Over se cargó correctamente
	if game_over_scene:
		var nivel_origen = get_tree().current_scene.get_scene_file_path()  # obtener la ruta de la escena actual
		game_over_scene.set_nivel_origen(nivel_origen)  # pasar la ruta a la escena de Game Over
		# añadir la escena de Game Over al árbol de escenas
		get_tree().root.add_child(game_over_scene)
		
		# eliminar la escena actual del árbol de escenas
		get_tree().current_scene.queue_free()
	else:
		print("Error: No se pudo instanciar la escena de Game Over")

func _on_cinematica_final_victoria_finished() -> void:
	# instanciar la escena de menú de inicio
	var menu_inicio_scene = MENU_INICIO.instantiate()

	# añadir la nueva escena al árbol de escenas
	get_tree().root.add_child(menu_inicio_scene)

	# eliminar la escena actual
	get_tree().current_scene.queue_free()
