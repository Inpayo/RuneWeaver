extends CharacterBody2D

var speed = 500

var dead = false
var player_detected = false
var direction = Vector2.ZERO
var player

func _ready():
	dead = false
	
func _physics_process(_delta):
	if !dead:
		$Player_detection/CollisionShape2D.disabled = false
		if player_detected:
			direction = (player.position-position).normalized()
			velocity = direction * speed
		else:
			velocity = Vector2.ZERO
	else:
		$Player_detection/CollisionShape2D.disabled = true
	move_and_slide()

func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_detected = true
		player = body

func _on_player_detection_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_detected = false
		player = body
