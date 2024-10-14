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

func limpiar_enemigos():
	for enemigos in get_tree().get_nodes_in_group("Enemigos"):
		enemigos.queue_free()  # Llama a la función destroy_enemigo() en el enemigo	
		
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Meteoros"):
		area.destroy()
		queue_free()
	else: 
		if area.is_in_group("Enemigos"):  # Comprobar si el área es un enemigo
			area.destroy_enemigo()
			area.call_deferred("queue_free")
			queue_free()  # Eliminar la bala  # Llama a la función en cada enemigo
		elif area.is_in_group("Jefe"):  # Comprobar si el área es el jefe
			# Reducir la vida del jefe llamando a la función _recibir_daño()
			area._recibir_daño()
			# Si la vida del jefe es menor o igual a 0, eliminar al jefe
			if area.vida_actual <= 0:
				area._destruir_jefe()
				
			# Eliminar la bala después de golpear al jefe
			queue_free()
