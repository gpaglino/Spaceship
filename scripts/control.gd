extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_jugar_pressed() -> void:
	#aca lo q queres que pase cuando clickeas jugar en este caso cambia a la escena de jugar
	get_tree().change_scene_to_file("res://escenas/escena_del_guego.tscn")
	pass # Replace with function body.


func _on_salir_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.


	
