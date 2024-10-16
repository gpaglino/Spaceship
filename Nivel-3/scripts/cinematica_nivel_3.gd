extends Node2D

@onready var video_stream_player_n3 = $VideoStreamPlayerN3
@onready var timer_n3 = $TimerN3

func _ready() -> void:
	
	timer_n3.wait_time = 22
	timer_n3.one_shot = true
	timer_n3.start()
	video_stream_player_n3.play()


func _on_video_stream_player_n_3_finished() -> void:
	# detener la reproducción del video
	video_stream_player_n3.stop()

	get_tree().change_scene_to_file("res://Nivel-3/escenas/Nivel-3.tscn")
