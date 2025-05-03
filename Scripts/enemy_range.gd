extends CharacterBody2D

@export var speed: float = 300.0
@export var Hp: int = 20
var last_location = null
var dead: bool = false
var player_detected: bool = false
var player_in_range: bool = false
var direction: Vector2 = Vector2.ZERO
var player
var knockback: Vector2 = Vector2.ZERO
var knockback_timer: float = 0.0

func _ready():
	dead = false
	
func _physics_process(_delta):
	if Hp <= 0:
		dead = true

	if !dead:
		$Player_detection/Detection.disabled = false
		
		if knockback_timer > 0.0:
			velocity = knockback
			knockback_timer -= _delta
			if knockback_timer <= 0.0:
				knockback = Vector2.ZERO
		
		if player_in_range:
			pass
		
		if player_detected and knockback_timer <= 0.0:
			direction = position.direction_to(player.position)
			velocity = direction * speed * _delta * 50 * -1
		else:
			velocity = Vector2.ZERO

	else:
		$Player_detection/Detection.disabled = true
	move_and_slide()

func received_damage():
	pass

func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_detected = true
		player = body

func _on_player_detection_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_detected = false


func apply_knockback(knockback_direction: Vector2, intensity: float, time: float) -> void:
	knockback = knockback_direction * intensity
	knockback_timer = time

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		var knockback_self = direction * -1
		body.apply_knockback(direction, 850.0, 0.12)
		body.received_damage(20)
		apply_knockback(knockback_self, 150.0, 0.12)


func _on_attack_range_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_range = true
		player = body


func _on_attack_range_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_range = false
