extends Sprite2D

@onready var direction = Vector2.RIGHT.rotated(rotation)
var damage = 20
var speed: float = 750
var KBIntensity = 750
var KBTime = 0.12



func _physics_process(delta: float) -> void:
	position += Vector2.RIGHT.rotated(rotation) * speed * delta
