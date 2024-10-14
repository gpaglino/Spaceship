extends Control

const CINEMATICA_N_1 = preload("res://Nivel-1/escenas/cinematicaN1.tscn")

# Nuevos límites de volumen
var volumen_minimo = -40
var volumen_maximo = 20

# Se llama cuando el nodo entra en el árbol de la escena por primera vez.
func _ready() -> void:
	# Inicializamos el valor del slider en el máximo volumen (0 dB)
	$VBoxContainer2/HSlider.value = volumen_maximo

	# También asegúrate de que el slider tenga el rango correcto
	$VBoxContainer2/HSlider.min_value = volumen_minimo
	$VBoxContainer2/HSlider.max_value = volumen_maximo

	# Ajustar el volumen del AudioServer al valor inicial del slider
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), $VBoxContainer2/HSlider.value)

# Función que se llama cuando el slider cambia
func _on_h_slider_value_changed(value: float) -> void:
	# Ajustar el volumen de la pista principal del juego (bus "Master") en decibelios
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)

# Función que se llama cuando presionas "Jugar"
func _on_jugar_pressed() -> void:
	# Cambiar a la cinemática del Nivel 1
	get_tree().change_scene_to_file("res://Nivel-1/escenas/cinematicaN1.tscn")

# Función que se llama cuando presionas "Salir"
func _on_salir_pressed() -> void:
	get_tree().quit()
