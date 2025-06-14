extends Sprite2D
var damage = 10
var speed: float = 2250
var velocity = 0
var KBTime = 0.16
var KBIntensity = 750
var direction
var last_location
@onready var init_location = global_position

func _physics_process(delta: float) -> void:
	position += Vector2.RIGHT.rotated(rotation) * speed * delta
	last_location = global_position
	direction = (last_location - init_location).normalized()
	if $FistDeath.time_left == 0:
		queue_free()
