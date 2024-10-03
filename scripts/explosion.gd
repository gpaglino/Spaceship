extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.start(0.5)# Tiempo de duración de la explosión
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass


func _on_timer_timeout() -> void:
	queue_free()
	pass # Replace with function body.


func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "explosion":
		queue_free()  # Elimina la explosión después de que termine
	pass # Replace with function body.

	
