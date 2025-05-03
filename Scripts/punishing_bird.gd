extends CharacterBody2D

var speed = 500
var last_location
var dead = false
var player_detected = false
var direction = Vector2.ZERO
var player

func _ready():
	dead = false
	
func _physics_process(_delta):
	if !dead:
		$Player_detection/Detection.disabled = false
		if player_detected:
			direction = position.direction_to(player.position)
			velocity = direction * speed * _delta * 50
		else:
			if last_location != null:
				if not (last_location - position) > Vector2(100,100) and not (last_location - position) < Vector2(-100,-100):
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
