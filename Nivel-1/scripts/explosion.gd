extends AnimatedSprite2D

@onready var timer = $Timer 
@onready var sonidoExplosion: AudioStreamPlayer2D = $AudioStreamPlayer2D

var tiempoAnimacion = 1.0  # duración de la animación en segundos

func _ready() -> void:
	# calcular la duración total de la animación
	var frame_count = sprite_frames.get_frame_count(animation)  # obtiene el número de frames de la animación actual
	tiempoAnimacion = float(frame_count) / 10  # calcular la duración en base a los frames

	# configurar el Timer
	timer.wait_time = tiempoAnimacion
	timer.one_shot = true  # se dispara solo una vez
	timer.start()  # iniciar el Timer

	# reproducir la animación
	play()
	sonidoExplosion.play()  # reproducir el sonido de la explosión

# eliminar el AnimatedSprite2D después de que se termine la animación
func _on_timer_timeout() -> void:
	queue_free()  # eliminar el nodo de la escena
