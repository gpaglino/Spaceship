extends Area2D


class_name Balas

@export
var speed := 600

enum DireccionBala{
	TOP,
	BOTTOM
}
@export
var direction : DireccionBala


func _process(delta):
	match direction:
		DireccionBala.BOTTOM:
			global_position.y += delta * speed
		DireccionBala.TOP:
			global_position.y += delta * speed


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()
