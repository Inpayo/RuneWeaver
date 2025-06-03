extends Sprite2D
var damage = 10
var speed: float = 2250
var velocity = 0
var KBTime = 0.24
var KBIntensity = 300

func _physics_process(delta: float) -> void:
	position += Vector2.RIGHT.rotated(rotation) * speed * delta
	if $FistDeath.time_left == 0:
		queue_free()
