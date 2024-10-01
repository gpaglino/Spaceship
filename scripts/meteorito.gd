extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$AnimacionMeteorito.play("MovimientoMeteoro")
	$AnimacionMeteorito.set_speed_scale(1.0)  # Aumenta la velocidad. 1 es la velocidad normal.

	 # Aumenta la velocidad (1 es el valor normal)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
