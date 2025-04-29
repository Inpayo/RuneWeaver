extends CharacterBody2D

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
@export var Speed: float = 800
@export var Acceleration: float = 2400
@export var Friction: float = Acceleration/Speed
var input_direction = Vector2.ZERO
@export var Bullet : PackedScene
@export var Keyboard: bool = true

func Mode_toggle():
	if Input.is_action_just_pressed("Swap_mode"):
		Keyboard = not Keyboard
		if Keyboard:
			Input.mouse_mode = (Input.MOUSE_MODE_VISIBLE)
		else:
			Input.mouse_mode = (Input.MOUSE_MODE_CAPTURED)
		print(Keyboard)

func get_input(_delta):
	if Keyboard:
		input_direction = Input.get_vector("Move_left_keyboard", "Move_right_keyboard", "Move_up_keyboard", "Move_down_keyboard")
	else:
		input_direction = Input.get_vector("Move_left_controller", "Move_right_controller", "Move_up_controller", "Move_down_controller")
	if input_direction != Vector2.ZERO :
		$Sprite2D/AnimationPlayer.play("Walking")
	else:
		$Sprite2D/AnimationPlayer.play("Idle")
	if input_direction.x > 0:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false
		
	input_direction = input_direction.normalized()
	
	if Input.is_action_just_pressed("Toggle_mouse_aim"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	
	velocity += input_direction * Acceleration * _delta
	
func Apply_friction(_delta):
	if input_direction == Vector2.ZERO:
		velocity -= velocity * Friction ** 2 * _delta
	else:
		velocity -= velocity * Friction * _delta
	
func _physics_process(_delta):
	Mode_toggle()
	get_input(_delta)
	Apply_friction(_delta)
	move_and_slide()
	
func player():
	pass
