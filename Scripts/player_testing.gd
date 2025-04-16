extends CharacterBody2D

@export var speed = 600

func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if Input.is_physical_key_pressed(KEY_SHIFT):
		speed = 1200
	else:
		speed = 600
	velocity = input_direction * speed

func _physics_process(_delta):
	get_input()
	move_and_slide()
	
func player():
	pass
