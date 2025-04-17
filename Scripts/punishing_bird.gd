extends CharacterBody2D

var speed = 50

var dead = false
var player_detected = false
var player

func _ready():
	dead = false
	
func _physics_process(_delta):
	if !dead:
		$Player_detection/CollisionShape2D.disabled = false
		if player_detected:
			position += (player.position - position) / speed
	else:
		$Player_detection/CollisionShape2D.disabled = true

func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_detected = true
		player = body

func _on_player_detection_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_detected = false
		player = body
		
func _on_hitbox_area_entered(area: Area2D) -> void:
	pass
