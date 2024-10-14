extends Node2D

@onready var video_stream_player = $VideoStreamPlayer2
@onready var timer = $Timer2
const ESCENA_DEL_JUEGO = preload("res://Nivel-1/escenas/escena_del_Juego.tscn")

func _ready() -> void:
	timer.wait_time = 22
	timer.one_shot = true
	timer.start()
	video_stream_player.play()



func _on_video_stream_player_2_finished() -> void:
	
	video_stream_player.stop()
	# Asegúrate de que el video se haya detenido antes de cambiar de escena
	get_tree().change_scene_to_file("res://Nivel-2/escenas/nivel_2.tscn")
