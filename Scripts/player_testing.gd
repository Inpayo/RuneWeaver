extends CharacterBody2D

@export var Speed = 800
@export var Acceleration = 2400
@export var Friction = Acceleration/Speed
var input_direction = Vector2.ZERO

func get_input(_delta):
	var input_direction = Input.get_vector("Move_left", "Move_right", "Move_up", "Move_down")
	input_direction = input_direction.normalized()
	
	velocity += input_direction * Acceleration * _delta
	
func Apply_friction(_delta):
	velocity -= velocity * Friction * _delta
	
func _physics_process(_delta):
	get_input(_delta)
	Apply_friction(_delta)
	move_and_slide()
	
func player():
	pass
