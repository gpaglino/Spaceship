extends Node2D

const enemigos = preload("res://Nivel-2/escenas/enemigos.tscn")

func _ready():
	crear_enemigos()
	
func crear_enemigos():
	for i in range(8):
		var enemy = enemigos.instantiate()  # Asegúrate de que sea una PackedScene
		enemy.position = Vector2(100 + i * 100, 50)  # Posiciones horizontales
		add_child(enemy)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
