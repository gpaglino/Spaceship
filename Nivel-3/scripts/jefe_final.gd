extends Area2D

@onready var cinematica_final_victoria: VideoStreamPlayer = $"../CinematicaFinalVictoria"
@onready var meteorito: Meteorito = $"../Meteorito"
@onready var spawn_meteoro: Timer = $"../SpawnMeteoro"

const MENU_INICIO = preload("res://Nivel-1/escenas/menu_inicio.tscn")
# Referencia a la barra de vida (estática, fuera del jefe-final)
@onready var barra_vida: ProgressBar = $"../BarraDeVida"
@onready var balas: Balas = $"../Balas"

# Variables
var vida_maxima = 30  # Vida máxima del jefe-final
var vida_actual = 30  # Vida actual del jefe-final
var velocidad = 300  # Velocidad de movimiento del jefe-final
var direccion = Vector2()  # Dirección de movimiento
var tiempo_cambio_direccion = 2.0  # Tiempo para cambiar de dirección
var tiempo_desde_cambio = 0.0  # Temporizador para controlar los cambios de dirección
var tamaño_pantalla = Vector2()  # Tamaño de la pantalla




# Se llama cuando el nodo entra en el árbol de la escena por primera vez
func _ready() -> void:
	tamaño_pantalla = get_viewport_rect().size  # Obtener el tamaño de la pantalla
	_cambiar_direccion()  # Establecer una dirección inicial
	
	# Inicializar la barra de vida
	barra_vida.max_value = vida_maxima
	barra_vida.value = vida_actual

# Se llama cada frame. 'delta' es el tiempo transcurrido desde el frame anterior.
func _process(delta: float) -> void:
	# Mover al jefe-final en la dirección actual
	position += direccion * velocidad * delta
	
	# Verificar los límites de la pantalla y ajustar la dirección si es necesario
	_verificar_limites()

	# Actualizar el temporizador
	tiempo_desde_cambio += delta
	
	# Cambiar de dirección después de cierto tiempo
	if tiempo_desde_cambio >= tiempo_cambio_direccion:
		_cambiar_direccion()
		tiempo_desde_cambio = 0.0

# Función para cambiar la dirección de movimiento
func _cambiar_direccion() -> void:
	# Elegir una nueva dirección aleatoria
	var angulo = randf_range(0, PI * 2)  # Ángulo aleatorio entre 0 y 360 grados
	direccion = Vector2(cos(angulo), sin(angulo)).normalized()  # Vector de dirección normalizado

# Función para verificar los límites de la pantalla
func _verificar_limites() -> void:
	if position.x < 0 or position.x > tamaño_pantalla.x:
		direccion.x = -direccion.x
	if position.y < 0 or position.y > tamaño_pantalla.y:
		direccion.y = -direccion.y


# Función para reducir la vida del jefe
func _recibir_daño() -> void:
	vida_actual -= 1  # Reducir la vida en 1 por cada disparo
	barra_vida.value = vida_actual  # Actualizar la barra de vida

	# Verificar si la vida llega a 0
	if vida_actual <= 0:
		_destruir_jefe()

# Función para destruir al jefe-final
func _destruir_jefe() -> void:
		# Detener cualquier acción del jefe
	queue_free()  # Eliminar al jefe-final

		# Reproducir la cinemática de victoria
	if cinematica_final_victoria:
		cinematica_final_victoria.visible = true
		cinematica_final_victoria.play()
	#oculto los meteoritos y freno el spawn de meteoros para que no se vean con la cinematica
	spawn_meteoro.stop()
	limpiar_meteoritos()
	


# Función para ocultar todos los meteoritos en la escena
func limpiar_meteoritos() -> void:
# Obtener todos los nodos en el grupo "Meteoros" y ocultarlos
	for meteoro in get_tree().get_nodes_in_group("Meteoros"):
		meteoro.queue_free()
