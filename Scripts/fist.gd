extends Sprite2D

signal Hit

var speed: float = 2250
@onready var enemy_hitbox: Area2D = $"../Player/Hitbox"

func _physics_process(delta: float) -> void:
	position += Vector2.RIGHT.rotated(rotation) * speed * delta
	if $FistDeath.time_left == 0:
		queue_free()
	
	if $RayCast2D.is_colliding():
		var entity = $RayCast2D.get_collider()
		entity = entity.get_parent()
		entity.received_damage(20)
		#emit_signal("Hit", entity, 20)
		queue_free()
