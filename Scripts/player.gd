extends CharacterBody2D

func _ready() -> void:
	$Hitbox/HurtyWurty.disabled = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	

var chance: float = 0.0
@export var luck: float = 1.0
var Fisting: bool = true
@export var Hp: int = 100
var current_Hp: int = Hp
@export var Speed: float = 800
@export var Acceleration: float = 2400
@export var Friction: float = Acceleration/Speed
var input_direction = Vector2.ZERO
@export var Fist : PackedScene
@export var Spell: PackedScene

@export var Keyboard: bool = true
var knockback: Vector2 = Vector2.ZERO
var knockback_timer: float = 0.0
var dead: bool = false
var ArrDirOrigin
@onready var Left: Marker2D = $"Arrow_anchor/Attacks/Left Hook"
var con: float = 0.0

func Mode_toggle():
	current_Hp = clamp(current_Hp, 0, Hp)
	if Input.is_action_just_pressed("Swap_mode"):
		Keyboard = not Keyboard
		if Keyboard:
			Input.mouse_mode = (Input.MOUSE_MODE_VISIBLE)
		else:
			Input.mouse_mode = (Input.MOUSE_MODE_CAPTURED)

func get_input(_delta):
	if Keyboard:
		if Input.is_action_just_pressed("SP1_Key") or Input.is_action_just_pressed("SP2_Key") or Input.is_action_just_pressed("SP3_Key") or Input.is_action_just_pressed("SP4_Key"):
			Fisting = false
			Fight()
	elif !Keyboard:
		if Input.is_action_just_pressed("SP1_Con") or Input.is_action_just_pressed("SP2_Con") or Input.is_action_just_pressed("SP3_Con") or Input.is_action_just_pressed("SP4_Con"):
			Fisting = false
			Fight()
	
	var facing = Vector2.ZERO
	ArrDirOrigin = get_node("Arrow_anchor/Arrow")
	var ArrDir = ArrDirOrigin.TDir

	if Keyboard:
		input_direction = Input.get_vector("Move_left_keyboard", "Move_right_keyboard", "Move_up_keyboard", "Move_down_keyboard")
	else:
		input_direction = Input.get_vector("Move_left_controller", "Move_right_controller", "Move_up_controller", "Move_down_controller")
	
	if knockback_timer <= 0.0:
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
	
	if Keyboard:
		if Input.is_action_just_pressed("Fist_keyboard"):
			Fisting = true
			Fight()
	elif !Keyboard:
		if Input.is_action_just_pressed("Fist_controller"):
			Fisting = true
			Fight()
		
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
	
	if not dead:
		Mode_toggle()
		get_input(_delta)
		Apply_friction(_delta)
		
		if knockback_timer > 0.0:
			$Sprite2D/AnimationPlayer.play("Hit")
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
			on_death()
		
	
func on_death():
	dead = true
	$Hitbox/HurtyWurty.disabled = true
	$Sprite2D/AnimationPlayer.play("death")
	
func luck_change(value):
	luck += value
func get_luck():
	return luck
	
func player():
	pass
	
func Fight():
	var punching
	var SPC = ""
	var TTF

	if Fisting == true:
		punching = Fist.instantiate()
	elif Fisting == false and con < 1:
		punching = Spell.instantiate()
		if Input.is_action_just_pressed("SP1_Key") or Input.is_action_just_pressed("SP1_Con"):
			SPC = "SP1"
			TTF = punching.get_node("SP1/Mana_req1")
		elif Input.is_action_just_pressed("SP2_Key") or Input.is_action_just_pressed("SP2_Con"):
			SPC = "SP2"
			TTF = punching.get_node("SP2/Mana_req2")
		elif Input.is_action_just_pressed("SP3_Key") or Input.is_action_just_pressed("SP3_Con"):
			SPC = "SP3"
			TTF = punching.get_node("SP3/Mana_req3")
		elif Input.is_action_just_pressed("SP4_Key") or Input.is_action_just_pressed("SP4_Con"):
			SPC = "SP4"
			TTF = punching.get_node("SP4/Mana_req4")
		punching.GetVars(SPC)
		
		TTF.timeout.connect(Callable(self, "Casted"))
		TTF.Ready.connect(Callable(self, "Casting"))
		
	
	if Fisting == true or con < 1:
		punching.position = $Arrow_anchor.global_position
		punching.rotation = (ArrDirOrigin.global_position - $Arrow_anchor.global_position).angle()
		get_parent().add_child(punching)

func Casted():
	con -= 1
	
func Casting():
	con += 1
