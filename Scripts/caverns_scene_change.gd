extends Area2D
@export var location = Vector2(17082.0, -2413.0)
 

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.position = location
