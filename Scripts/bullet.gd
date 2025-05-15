extends Sprite2D

@onready var RayCast: RayCast2D = $RayCast2D
@onready var player: CharacterBody2D = $"../Player"
@onready var player_hitbox: Area2D = $"../Player/Hitbox"

var speed: float = 750

func _physics_process(delta: float) -> void:
	position += Vector2.RIGHT.rotated(rotation) * speed * delta
	
	if $Sprite2D/AnimationPlayer.animation_finished:
		$Sprite2D/AnimationPlayer.play("shoot")
	
	if RayCast.is_colliding():
		if RayCast.get_collider() == player or RayCast.get_collider() == player_hitbox:
			if randf_range(0.0, 100.0) > player.get_luck():
				damage_player()
		queue_free()

func damage_player():
	player.apply_knockback((player.position - position).normalized(), 750 ,0.12)
	player.received_damage(20)
	player.luck_change(20)
