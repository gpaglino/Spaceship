extends Area2D

class_name Balas

# velocidad de la bala
@export
var speed := 600

#enumerador para las direcciones de la bala
enum DireccionBala {
	TOP,
	BOTTOM
}

# dirección en la que se mueve la bala
@export
var direction : DireccionBala

# Función que se llama en cada frame
func _process(delta):
	match direction:
		DireccionBala.BOTTOM:
			global_position.y += delta * speed  # mover hacia abajo
		DireccionBala.TOP:
			global_position.y -= delta * speed   #mover hacia arriba

# señal que llama cuando la bala sale de la pantalla
func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()  # eliminar el objeto para liberar memoria

# Función para crear una nueva bala
static func shoot(direction: DireccionBala, position: Vector2, parent: Node) -> Node2D:
	var BalaScene = preload("res://Nivel-1/escenas/Balas.tscn") 
	var bala = BalaScene.instantiate()  # Instancia la escena de bala
	bala.direction = direction  # Establecer la dirección de la bala
	bala.global_position = position  # Establecer la posición inicial de la bala
	parent.add_child(bala)  # Agrega la bala al nodo padre
	return bala  # retorna la instancia de la bala

func limpiar_enemigos():
	for enemigos in get_tree().get_nodes_in_group("Enemigos"):
		enemigos.queue_free() 

#FUNCIO QUE MANEJA LAS COLISIONES DE LA BALA CON LOS TRES ENEMIGOS DE LOS NIVELES
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Meteoros"):
		area.destroy()
		# eliminar la bala después de golpear al meteoro
		queue_free()
	else: 
		if area.is_in_group("Enemigos"):  
			area.destroy_enemigo()
			area.call_deferred("queue_free")
			# eliminar la bala después de golpear al enemigo
			queue_free() 
		elif area.is_in_group("Jefe"):  
		
			area._recibir_daño()
			#si la vida del jefe es menor o igual a 0, eliminar al jefe
			if area.vida_actual <= 0:
				area._destruir_jefe()
				
			# eliminar la bala después de golpear al jefe
			queue_free()
