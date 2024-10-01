extends AudioStreamPlayer2D

func _ready():
	# Inicia la música
	play()  

func _process(delta):
	#Verifica si la musica termino
	if not is_playing(): 
		# reproduce de nuevo
		play()  
