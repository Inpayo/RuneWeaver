extends Sprite2D

@onready var RayCast: RayCast2D = $RayCast2D
@onready var player: CharacterBody2D = $"../Player"
@onready var player_hitbox: Area2D = $"../Player/Hitbox"
@onready var init_location = position
var last_location
var direction 
var damage = 20
var speed: float = 750
var KBIntensity = 750
var KBTime = 0.12


func _physics_process(delta: float) -> void:
	position += Vector2.RIGHT.rotated(rotation) * speed * delta
	last_location = position
	direction = (last_location - init_location).normalized()
	
	if $Sprite2D/AnimationPlayer.animation_finished:
		$Sprite2D/AnimationPlayer.play("shoot")
