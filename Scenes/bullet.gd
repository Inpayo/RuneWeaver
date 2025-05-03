extends Sprite2D

@onready var RayCast: RayCast2D = $RayCast2D
var speed: float = 120.0

func _physics_process(delta: float) -> void:
	position += Vector2.RIGHT.rotated(rotation) * speed * delta
	if RayCast.is_colliding():
		queue_free()
