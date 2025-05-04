extends CharacterBody2D

func _ready() -> void:
	$Hitbox/HurtyWurty.disabled = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

@export var Hp: int = 100
var current_Hp: int = Hp
@export var Speed: float = 800
@export var Acceleration: float = 2400
@export var Friction: float = Acceleration/Speed
var input_direction = Vector2.ZERO
@export var Bullet : PackedScene
@export var Keyboard: bool = true
var knockback: Vector2 = Vector2.ZERO
var knockback_timer: float = 0.0


func Mode_toggle():
	current_Hp = clamp(current_Hp, 0, Hp)
	if Input.is_action_just_pressed("Swap_mode"):
		Keyboard = not Keyboard
		if Keyboard:
			Input.mouse_mode = (Input.MOUSE_MODE_VISIBLE)
		else:
			Input.mouse_mode = (Input.MOUSE_MODE_CAPTURED)

func get_input(_delta):

	var facing = Vector2.ZERO
	var ArrDirOrigin = get_node("Arrow_anchor/Arrow")
	var ArrDir = ArrDirOrigin.LMDir

	if Keyboard:
		input_direction = Input.get_vector("Move_left_keyboard", "Move_right_keyboard", "Move_up_keyboard", "Move_down_keyboard")
	else:
		input_direction = Input.get_vector("Move_left_controller", "Move_right_controller", "Move_up_controller", "Move_down_controller")
	if input_direction != Vector2.ZERO :
		$Sprite2D/AnimationPlayer.play("Walking")
	else:
		$Sprite2D/AnimationPlayer.play("Idle")
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		ArrDir.x = 0
	if abs(ArrDir.x) > 0:
		facing = ArrDir
	else:
		facing = input_direction
	if facing.x > 0:
		$Sprite2D.flip_h = true
	elif facing.x < 0:
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
	
	if knockback_timer > 0.0:
		velocity = knockback
		knockback_timer -= _delta
		if knockback_timer <= 0.0:
			knockback = Vector2.ZERO
	
	move_and_slide()
	

func apply_knockback(knockback_direction: Vector2, intensity: float, time: float) -> void:
	knockback = knockback_direction * intensity
	knockback_timer = time

func received_damage(damage: int):
	Hp -= damage
	if Hp <= 0:
		print("death")
	
func on_death():
	$Hitbox/HurtyWurty.disabled = true
	
func player():
	pass
