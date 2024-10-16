extends Control

# variable que almacena la ruta de donde se llamó a esta escena
var nivel_origen: String

func _ready() -> void:
	pass  


func _process(_delta: float) -> void:
	pass
	
# función que se ejecuta cuando el botón "Salir" es presionado
func _on_salir_pressed() -> void:
	get_tree().quit()  # cerrar la aplicación
	pass  # reemplazar con el cuerpo de la función

# función para recibir el nivel de origen
func set_nivel_origen(nivel: String) -> void:
	nivel_origen = nivel  # asignar el nivel de origen a la variable

# función que se ejecuta cuando el botón "Reintentar" es presionado
func _on_reintentar_pressed() -> void:
	if nivel_origen:
		# cambia a la escena del nivel de origen
		get_tree().change_scene_to_file(nivel_origen)
		
		queue_free()  # liberar la escena actual
		
	else:
		print("Error: No se pudo cargar el nivel de origen")  # mensaje de error si no hay nivel de origen
