extends AnimatedSprite2D

@onready var timer = $Timer  # Asegúrate de que tienes un Timer como nodo hijo de tu AnimatedSprite2D
@onready var sonidoExplosion: AudioStreamPlayer2D = $AudioStreamPlayer2D

var tiempoAnimacion = 1.0  # Duración de la animación en segundos

func _ready() -> void:
	# Calcular la duración total de la animación
	var frame_count = sprite_frames.get_frame_count(animation)  # Obtiene el número de frames de la animación actual
	tiempoAnimacion = float(frame_count) / 10 

	# Configurar el Timer
	timer.wait_time = tiempoAnimacion
	timer.one_shot = true  # Solo se dispara una vez
	timer.start()  # Iniciar el Timer

	# Reproducir la animación
	play()
	sonidoExplosion.play()

# Eliminar el AnimatedSprite2D después de que se termine la animación
func _on_timer_timeout() -> void:
	queue_free()
