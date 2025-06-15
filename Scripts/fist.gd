extends Sprite2D
var damage = 5
var speed: float = 2250
var velocity = 0
var KBTime = 0.16
var KBIntensity = 750
var element = "physical"
@onready var direction = Vector2.RIGHT.rotated(rotation)

func _physics_process(delta: float) -> void:
	position += Vector2.RIGHT.rotated(rotation) * speed * delta

	if $FistDeath.time_left == 0:
		queue_free()
