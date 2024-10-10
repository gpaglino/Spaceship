extends Node2D

const enemigos = preload("res://Nivel-2/escenas/enemigos.tscn")

func _ready():
	crear_enemigos()
	
func crear_enemigos():
	var filas = 4
	var columnas = 4
	var espaciamiento_x = 70  # Distancia entre columnas
	var espaciamiento_y = 70  # Distancia entre filas
	var posicion_inicial_y = 10  # Ajusta este valor para subir o bajar las naves
	
	
	for fila in range(filas):
		for columna in range(columnas):
			var enemy = enemigos.instantiate()
			enemy.position = Vector2(100 + columna * espaciamiento_x, posicion_inicial_y + fila * espaciamiento_y)  # Sube la posición inicial
			add_child(enemy)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
