extends CharacterBody2D

@export var speed: float = 500.0
var last_location = null
var dead: bool = false
var player_detected: bool = false
var direction: Vector2 = Vector2.ZERO
@onready var player: Node = $"../.."

func _ready():
	dead = false
	
func _physics_process(_delta):
	print(player)
	if !dead:
		$Player_detection/Detection.disabled = false
		if player_detected:
			direction = position.direction_to(player.position)
			velocity = direction * speed * _delta * 50
		else:
			if last_location != null:
				if not (last_location - position).x > 100 and not (last_location - position).x < -100 and not (last_location - position).y > 100 and not (last_location - position).y < -100:
					velocity = Vector2.ZERO
				else:
					direction = (last_location - position).normalized()
					velocity = direction * speed * _delta * 50
	else:
		$Player_detection/Detection.disabled = true
	move_and_slide()

func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_detected = true
		player = body

func _on_player_detection_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_detected = false
		last_location = player.position
		player = body


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body == player:
		var knockback_direction = position.direction_to(player.position)
		body.Apply_knockback(knockback_direction, 150.0, 0.12)
		print("knocking")
