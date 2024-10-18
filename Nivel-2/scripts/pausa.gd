extends CanvasLayer

# Variable para manejar el estado de pausa
var game_paused: bool = false

func _ready():
	# Ocultar el menú de pausa al inicio
	self.visible = false

func _input(event):
	if event.is_action_pressed("pausa"):
		toggle_pause()

# Función para pausar y reanudar el juego
func toggle_pause():
	game_paused = not game_paused
	get_tree().paused = game_paused
	
	# Mostrar u ocultar el menú de pausa
	self.visible = game_paused
