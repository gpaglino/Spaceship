extends Area2D

# Velocidad de la bala
@export
var speed := 300

# Enumerador para las direcciones de la bala
enum DireccionBala {
	TOP,
	BOTTOM
}

# Dirección en la que se mueve la bala
@export
var direction : DireccionBala

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
			# Mueve la bala en la dirección especificada
	match direction:
		DireccionBala.BOTTOM:
			global_position.y += delta * speed  # Mover hacia abajo
		DireccionBala.TOP:
			global_position.y -= delta * speed   # Mover hacia arriba
			
			
# Función para crear una nueva bala
static func shoot_enemigo(direction: DireccionBala, position: Vector2, parent: Node) -> Node2D:
	var BalaScene = preload("res://Nivel-2/escenas/balas_enemigos.tscn")  # Asegúrate de que la ruta es correcta
	var bala = BalaScene.instantiate()  # Instanciar la escena de la bala
	bala.direction = direction  # Establecer la dirección de la bala
	bala.global_position = position  # Establecer la posición inicial de la bala
	parent.add_child(bala)  # Agregar la bala al nodo padre
	return bala  # Retornar la instancia de la bala

func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()
	

func _on_area_entered(area: Area2D) -> void:
		if area.is_in_group("Naves"):
			area.destroy_nave()
			# destruir la nave y cambiar a game over
			area.call_deferred("queue_free")
			get_parent()._perder_partida()
