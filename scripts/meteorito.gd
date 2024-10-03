extends Area2D

class_name Meteorito

# Cargamos la escena de la explosión
var explosion_scena = preload("res://escenas/Explosion.tscn")


var speed = 200
var life

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var scal = randf_range(0.7, 1.2)  # Obtener una escala aleatoria entre 0.5 y 0.9
	scale = Vector2(scal, scal)  # Asignar la misma escala a ambos componentes
	

	# Ajustar la vida y la velocidad según la escala
	if scal >= 1.0:
		life = 3 
		speed = 200  # Reducido de 500 a 400
	elif scal < 0.9:
		life = 2
		speed = 300  # Reducido de 600 a 500
	elif scal <= 0.7:
		life = 1 
		speed = 400  # Reducido de 750 a 600

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += Vector2(0, speed * delta)  # Mover el meteoro hacia abajo

func _on_area_entered(area: Area2D) -> void:
	if area.name == "Balas" or area.name == "Nave":
		# Reemplazamos el meteorito por una explosión
		spawn_explosion()
		queue_free()  # Eliminamos el meteorito

		
		
func spawn_explosion():
	# Instanciar la escena de la explosión
	var explosion = explosion_scena.instantiate()  
	
	# Colocar la explosión en la misma posición del meteorito
	explosion.position = position  
	
	# Añadir la explosión a la escena
	get_parent().add_child(explosion)  

	# Obtener el AnimatedSprite2D de la explosión
	var animated_sprite = explosion.get_node("Explosion")
	if animated_sprite:
		animated_sprite.play("Explosion")  # Asegúrate de que el nombre de la animación es correcto
