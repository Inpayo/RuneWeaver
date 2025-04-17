extends CharacterBody2D

var MaxVel = 600
var HP = 50
var Knockback = Vector2.ZERO
var Vel = 0

func get_input():
	var input_direction = Input.get_vector("Move_left", "Move_right", "Move_up", "Move_down")
	if input_direction.length() > 0:
		input_direction = input_direction.normalized()
	if Input.is_action_pressed("Move_up") or Input.is_action_pressed("Move_down") or Input.is_action_pressed("Move_left") or Input.is_action_pressed("Move_right"):
		if Input.is_action_pressed("sprint"):
			Vel += 24
			if Vel >= 1200:
				Vel -= 48
		else:
			Vel += 12
			if Vel >= 1200:
				Vel -= 24
	else:
		Vel = 0

	
	velocity = input_direction * Vel




func _physics_process(_delta):
	get_input()
	move_and_slide()
	
func _on_hitbox_area_entered(area: Area2D) -> void:
	HP -= 5
