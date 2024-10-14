extends Node2D

const Meteoro = preload("res://Nivel-1/escenas/Meteorito.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _perder_partida() -> void:
	# Usa call_deferred para limpiar los meteoritos después de la física
	call_deferred("limpiar_meteoritos")
	
	# Cambia a la escena de Game Over de forma diferida
	call_deferred("cambiar_a_game_over")

func limpiar_meteoritos():
	for meteoro in get_tree().get_nodes_in_group("Meteoros"):
		meteoro.queue_free()	
		
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
		
func cambiar_a_game_over() -> void:
	get_tree().change_scene_to_file("res://Nivel-1/escenas/GameOver.tscn")
