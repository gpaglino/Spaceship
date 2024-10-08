extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func _on_salir_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.




func _on_reintentar_pressed() -> void:
	# Obtener la ruta de la escena del juego
	get_tree().change_scene_to_file("res://Nivel-1/escenas/escena_del_Juego.tscn")
