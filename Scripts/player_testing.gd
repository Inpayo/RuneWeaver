extends CharacterBody2D

@export var Speed = 800
@export var Acceleration = 2400
@export var Friction = Acceleration/Speed
var input_direction = Vector2.ZERO

func get_input(_delta):
	
	input_direction = Input.get_vector("Move_left", "Move_right", "Move_up", "Move_down")
	if input_direction != Vector2.ZERO :
		$Sprite2D/AnimationPlayer.play("Walking")
	else:
		$Sprite2D/AnimationPlayer.play("Idle")
	if input_direction.x > 0:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false
		
	input_direction = input_direction.normalized()
	
	velocity += input_direction * Acceleration * _delta
	
func Apply_friction(_delta):
	if input_direction == Vector2.ZERO:
		velocity -= velocity * Friction ** 2 * _delta
	else:
		velocity -= velocity * Friction * _delta
	
func _physics_process(_delta):
	get_input(_delta)
	Apply_friction(_delta)
	move_and_slide()
	
func player():
	pass
