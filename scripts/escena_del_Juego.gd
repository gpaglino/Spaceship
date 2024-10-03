extends Node2D

var Meteoro = preload("res://escenas/meteorito.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_spawn_meteoro_timeout() -> void:
	var meteoro_count = 3  # Número de meteoritos a spawn

	for i in range(meteoro_count):
		var meteoro = Meteoro.instantiate()

# Generar una posición aleatoria en la parte superior de la pantall
		var screen_width = get_viewport_rect().size.x
		var random_x = randi_range(0, int(screen_width))  # Posición aleatoria en el eje X
		meteoro.position = Vector2(random_x, -50)  # Aparece fuera de la pantalla, por encima

		# Añadir el meteoro a la escena
		get_parent().add_child(meteoro)
