extends Control

const CINEMATICA_N_1 = preload("res://Nivel-1/escenas/cinematicaN1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_jugar_pressed() -> void:
	#CINEMATICA NIVEL 1
	#aca lo q queres que pase cuando clickeas jugar en este caso cambia a la CinematicaN1
	get_tree().change_scene_to_file("res://Nivel-1/escenas/cinematicaN1.tscn")
	pass # Replace with function body.


func _on_salir_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.


	
