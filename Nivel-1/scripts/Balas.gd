extends Area2D

class_name Balas
# Velocidad de la bala
@export
var speed := 600

# Enumerador para las direcciones de la bala
enum DireccionBala {
	TOP,
	BOTTOM
}

# Dirección en la que se mueve la bala
@export
var direction : DireccionBala

# Función que se llama en cada frame
func _process(delta):
	# Mueve la bala en la dirección especificada
	match direction:
		DireccionBala.BOTTOM:
			global_position.y += delta * speed  # Mover hacia abajo
		DireccionBala.TOP:
			global_position.y -= delta * speed   # Mover hacia arriba

# Se llama cuando la bala sale de la pantalla
func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()  # Eliminar el objeto para liberar memoria

# Función para crear una nueva bala
static func shoot(direction: DireccionBala, position: Vector2, parent: Node) -> Node2D:
	var BalaScene = preload("res://Nivel-1/escenas/Balas.tscn")  # Asegúrate de que la ruta es correcta
	var bala = BalaScene.instantiate()  # Instanciar la escena de la bala
	bala.direction = direction  # Establecer la dirección de la bala
	bala.global_position = position  # Establecer la posición inicial de la bala
	parent.add_child(bala)  # Agregar la bala al nodo padre
	return bala  # Retornar la instancia de la bala

	
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Meteoros"):
		area.destroy()
		queue_free()
	elif area.is_in_group("Enemigos"):
		area.destroy_enemigo()
		queue_free()
		
