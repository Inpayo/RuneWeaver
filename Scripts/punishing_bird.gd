extends CharacterBody2D

var speed = 600

var dead = false
var player_detected = false
@onready var player_postion = $"../../CharacterBody2D/Hitbox/HurtyWurty"
var player

func _ready():
	dead = false
	
func _physics_process(_delta):
	if !dead:
		$Player_detection/CollisionShape2D.disabled = false
		if player_detected:
			var direction = (player_postion-position).normalized()
			velocity += direction * speed
	else:
		$Player_detection/CollisionShape2D.disabled = true
		
func Enemy_movement(CurrentX, CurrentY, ToX, ToY):
	pass

func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_detected = true
		player = body

func _on_player_detection_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_detected = false
		player = body
