extends CharacterBody2D

var speed = 600

func get_input():
	var input_direction = Input.get_vector("Move_left", "Move_right", "Move_up", "Move_down")
	if input_direction.length() > 0:
		input_direction = input_direction.normalized()
	if Input.is_action_pressed("sprint"):
		speed = 1200
	else:
		speed = 600
	velocity = input_direction * speed
	




func _physics_process(_delta):
	get_input()
	move_and_slide()
	
func player():
	pass
