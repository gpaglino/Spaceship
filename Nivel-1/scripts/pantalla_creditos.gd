extends Node2D

@onready var pantalla_creditos: Node2D = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass




func _on_cerrar_pressed() -> void:
# Ocultar la pantalla de creditos
	if pantalla_creditos:
		pantalla_creditos.visible = false
