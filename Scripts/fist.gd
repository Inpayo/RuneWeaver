extends Sprite2D

var speed: float = 2250

func _physics_process(delta: float) -> void:
	position += Vector2.RIGHT.rotated(rotation) * speed * delta
	if $FistDeath.time_left == 0:
		queue_free()
