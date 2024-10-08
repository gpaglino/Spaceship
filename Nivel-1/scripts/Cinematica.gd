extends Node2D

@onready var video_stream_player = $VideoStreamPlayer  # Ajusta la ruta si es necesario
@onready var timer = $Timer  # Asegúrate de que el Timer esté en tu escena y ajusta la ruta

func _ready() -> void:
	# Configurar el Timer
	timer.wait_time = 14.5  # Duración en segundos
	timer.one_shot = true  # Asegúrate de que el Timer se ejecute solo una vez
	timer.start()  # Iniciar el Timer

	# Reproducir el video cuando la escena se inicie
	video_stream_player.play()


func _on_timer_timeout() -> void:
		# Detener el video manualmente cuando se acabe el tiempo del temporizador
	video_stream_player.stop()
	
	video_stream_player.queue_free()
	# Cambiar a la escena principal del juego

	get_tree().change_scene_to_file("res://Nivel-1/escenas/escena_del_Juego.tscn")
	
	pass # Replace with function body.
