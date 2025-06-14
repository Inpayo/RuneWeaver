extends CharacterBody2D


var chance: float = 0.0
@export var luck: float = 1.0

var Fisting: bool = true
@export var Fist : PackedScene
@export var Spell: PackedScene
@onready var Health_bar = $CanvasLayer2/ProgressBar
@onready var Restart = $RestartTime
@export var Hp: int = 100
var current_Hp: int = Hp

@export var Speed: float = 800
@export var Acceleration: float = 2400
@export var Friction: float = Acceleration/Speed
var knockback: Vector2 = Vector2.ZERO
var knockback_timer: float = 0.0
var input_direction = Vector2.ZERO
@onready var direction = input_direction

@export var Keyboard: bool = true

var dead: bool = false

var ArrDirOrigin

var con: float = 0.0

var KBIntensity = 600
var KBTime = 0.5
var damage = 10
var Scaling = 0.0
var ArrDir

var Thingy1 = [null,null,null,null]
var Thingy2 = [null,null,null,null]
var Thingy3 = [null,null,null,null]
var Thingy4 = [null,null,null,null]

var Severed_universe = false

func _ready() -> void:
	$CanvasLayer3/Control/HBoxContainer.connect("set_vars", Callable(self, "on_set_vars"))
	$Hitbox/HurtyWurty.disabled = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Health_bar.health_init(Hp)
	$CanvasLayer/Cooldowns/Cooldowns/HBoxContainer/VBoxContainer/SP1/TextureRect.texture = preload("res://Assets/Sprites/Q_Key_Dark.png")
	$CanvasLayer/Cooldowns/Cooldowns/HBoxContainer/VBoxContainer2/SP2/TextureRect.texture = preload("res://Assets/Sprites/E_Key_Dark.png")
	$CanvasLayer/Cooldowns/Cooldowns/HBoxContainer/VBoxContainer2/SP3/TextureRect.texture = preload("res://Assets/Sprites/C_Key_Dark.png")
	$CanvasLayer/Cooldowns/Cooldowns/HBoxContainer/VBoxContainer/SP4/TextureRect.texture = preload("res://Assets/Sprites/Z_Key_Dark.png")

func Mode_toggle():
	current_Hp = clamp(current_Hp, 0, Hp)
	if Input.is_action_just_pressed("Swap_mode") and !Severed_universe:
		Keyboard = not Keyboard
		if Keyboard:
			$CanvasLayer/Cooldowns/Cooldowns/HBoxContainer/VBoxContainer/SP1/TextureRect.texture = preload("res://Assets/Sprites/Q_Key_Dark.png")
			$CanvasLayer/Cooldowns/Cooldowns/HBoxContainer/VBoxContainer2/SP2/TextureRect.texture = preload("res://Assets/Sprites/E_Key_Dark.png")
			$CanvasLayer/Cooldowns/Cooldowns/HBoxContainer/VBoxContainer2/SP3/TextureRect.texture = preload("res://Assets/Sprites/C_Key_Dark.png")
			$CanvasLayer/Cooldowns/Cooldowns/HBoxContainer/VBoxContainer/SP4/TextureRect.texture = preload("res://Assets/Sprites/Z_Key_Dark.png")
		else:
			Input.mouse_mode = (Input.MOUSE_MODE_CAPTURED)
			$CanvasLayer/Cooldowns/Cooldowns/HBoxContainer/VBoxContainer/SP1/TextureRect.texture = preload("res://Assets/Sprites/PS5_L1.png")
			$CanvasLayer/Cooldowns/Cooldowns/HBoxContainer/VBoxContainer2/SP2/TextureRect.texture = preload("res://Assets/Sprites/PS5_R1.png")
			$CanvasLayer/Cooldowns/Cooldowns/HBoxContainer/VBoxContainer2/SP3/TextureRect.texture = preload("res://Assets/Sprites/PS5_R2.png")
			$CanvasLayer/Cooldowns/Cooldowns/HBoxContainer/VBoxContainer/SP4/TextureRect.texture = preload("res://Assets/Sprites/PS5_L2.png")

func get_input(_delta):
	
	if Input.is_action_just_pressed("OpenUI"):
		print("Nuts")
		_on_button_pressed()
	
	if Keyboard and !Severed_universe:
		if Input.is_action_just_pressed("restart"):
			get_tree().reload_current_scene()
			
		if Input.is_action_just_pressed("SP1_Key") or Input.is_action_just_pressed("SP2_Key") or Input.is_action_just_pressed("SP3_Key") or Input.is_action_just_pressed("SP4_Key"):
			Fisting = false
			Fight()
	elif !Keyboard and !Severed_universe:
		if Input.is_action_just_pressed("SP1_Con") or Input.is_action_just_pressed("SP2_Con") or Input.is_action_just_pressed("SP3_Con") or Input.is_action_just_pressed("SP4_Con"):
			Fisting = false
			Fight()
	
	var facing = Vector2.ZERO
	ArrDirOrigin = get_node("Arrow_anchor/Arrow")
	ArrDir = ArrDirOrigin.TDir

	if Keyboard and !Severed_universe:
		input_direction = Input.get_vector("Move_left_keyboard", "Move_right_keyboard", "Move_up_keyboard", "Move_down_keyboard")
	elif !Keyboard and !Severed_universe:
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
	
	if Keyboard and !Severed_universe:
		if Input.is_action_just_pressed("Fist_keyboard"):
			Fisting = true
			Fight()
	elif !Keyboard and !Severed_universe:
		if Input.is_action_just_pressed("Fist_controller"):
			Fisting = true
			Fight()
		
	input_direction = input_direction.normalized()
	
	if Input.is_action_just_pressed("Toggle_mouse_aim"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			
	if !$Gen_CD.is_stopped():
		var Progress = $Gen_CD.time_left/$Gen_CD.wait_time * 100
		$CanvasLayer/Cooldowns/Cooldowns/HBoxContainer/VBoxContainer/SP1/TextureProgressBar.value = Progress
		$CanvasLayer/Cooldowns/Cooldowns/HBoxContainer/VBoxContainer2/SP2/TextureProgressBar.value = Progress
		$CanvasLayer/Cooldowns/Cooldowns/HBoxContainer/VBoxContainer2/SP3/TextureProgressBar.value = Progress
		$CanvasLayer/Cooldowns/Cooldowns/HBoxContainer/VBoxContainer/SP4/TextureProgressBar.value = Progress
		
	if !$SP1.is_stopped() and $Gen_CD.is_stopped():
		var Progress = $SP1.time_left/$SP1.wait_time * 100
		$CanvasLayer/Cooldowns/Cooldowns/HBoxContainer/VBoxContainer/SP1/TextureProgressBar.value = Progress
	elif $SP1.is_stopped and $Gen_CD.is_stopped(): 
		$CanvasLayer/Cooldowns/Cooldowns/HBoxContainer/VBoxContainer/SP1/TextureProgressBar.value = 0.0
		
	if !$SP2.is_stopped() and $Gen_CD.is_stopped():
		var Progress = $SP2.time_left/$SP2.wait_time * 100
		$CanvasLayer/Cooldowns/Cooldowns/HBoxContainer/VBoxContainer2/SP2/TextureProgressBar.value = Progress
	elif $SP2.is_stopped and $Gen_CD.is_stopped(): 
		$CanvasLayer/Cooldowns/Cooldowns/HBoxContainer/VBoxContainer2/SP2/TextureProgressBar.value = 0.0
	
	if !$SP3.is_stopped() and $Gen_CD.is_stopped():
		var Progress = $SP3.time_left/$SP3.wait_time * 100
		$CanvasLayer/Cooldowns/Cooldowns/HBoxContainer/VBoxContainer2/SP3/TextureProgressBar.value = Progress
	elif $SP3.is_stopped and $Gen_CD.is_stopped(): 
		$CanvasLayer/Cooldowns/Cooldowns/HBoxContainer/VBoxContainer2/SP3/TextureProgressBar.value = 0.0
	
	if !$SP4.is_stopped() and $Gen_CD.is_stopped():
		var Progress = $SP4.time_left/$SP4.wait_time * 100
		$CanvasLayer/Cooldowns/Cooldowns/HBoxContainer/VBoxContainer/SP4/TextureProgressBar.value = Progress
	elif $SP4.is_stopped and $Gen_CD.is_stopped(): 
		$CanvasLayer/Cooldowns/Cooldowns/HBoxContainer/VBoxContainer/SP4/TextureProgressBar.value = 0.0
	

	
	if !Severed_universe:
		Acceleration = 2400
	elif Severed_universe:
		Acceleration = 0
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
		direction = input_direction
		
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

func received_damage(Damage: int):
		Hp -= Damage
		if Hp <= 0:
			on_death()
	
func on_death():
	if not dead:
		dead = true
		$Hitbox/HurtyWurty.disabled = true
		$Sprite2D/AnimationPlayer.play("death")
		$RestartTime.start()
	
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
	var CD_dur
	var RELEASE := false
	
	if Fisting == true and !Severed_universe and $FistCD.is_stopped():
		punching = Fist.instantiate()
		RELEASE = true
		$FistCD.start()
		
	elif Fisting == false and $Gen_CD.is_stopped() and !Severed_universe:
		punching = Spell.instantiate()
		if (Input.is_action_just_pressed("SP1_Key") or Input.is_action_just_pressed("SP1_Con")) and $SP1.is_stopped():
			SPC = "SP1"
			TTF = punching.get_node("SP1")
			print(Thingy1)
			TTF.Vars = Thingy1
			if Thingy1[0] != null or Thingy1[1] != null:
				RELEASE = true
			$CanvasLayer/Cooldowns/Cooldowns/HBoxContainer/VBoxContainer/SP1/TextureProgressBar.value = 100.0
		elif (Input.is_action_just_pressed("SP2_Key") or Input.is_action_just_pressed("SP2_Con")) and $SP2.is_stopped():
			SPC = "SP2"
			TTF = punching.get_node("SP2")
			TTF.Vars = Thingy2
			if Thingy2[0] != null or Thingy2[1] != null:
				RELEASE = true
			$CanvasLayer/Cooldowns/Cooldowns/HBoxContainer/VBoxContainer2/SP2/TextureProgressBar.value = 100.0
		elif (Input.is_action_just_pressed("SP3_Key") or Input.is_action_just_pressed("SP3_Con"))and $SP3.is_stopped():
			SPC = "SP3"
			TTF = punching.get_node("SP3")
			TTF.Vars = Thingy3
			if Thingy3[0] != null or Thingy3[1] != null:
				RELEASE = true
			$CanvasLayer/Cooldowns/Cooldowns/HBoxContainer/VBoxContainer2/SP3/TextureProgressBar.value = 100.0
		elif (Input.is_action_just_pressed("SP4_Key") or Input.is_action_just_pressed("SP4_Con")) and $SP4.is_stopped():
			SPC = "SP4"
			TTF = punching.get_node("SP4")
			TTF.Vars = Thingy4
			if Thingy4[0] != null or Thingy4[1] != null:
				RELEASE = true
			$CanvasLayer/Cooldowns/Cooldowns/HBoxContainer/VBoxContainer/SP4/TextureProgressBar.value = 100.0
		if RELEASE == true:
			punching.GetVars(SPC)
			CD_dur = TTF.CD_Dur
		
			get_node(SPC).start(CD_dur)
		$Gen_CD.start(1.0)
	
	if RELEASE == true:
		punching.position = $Arrow_anchor.global_position
		punching.rotation = (ArrDirOrigin.global_position - $Arrow_anchor.global_position).angle()
		if Fisting == false:
			punching.position = $Arrow_anchor.global_position + Vector2.RIGHT.rotated(punching.rotation).normalized() * 200
		get_parent().add_child(punching)
		RELEASE = false




func _on_hitbox_area_entered(area):
	if area.is_in_group("Enemy_attacks") or area.is_in_group("Enemies"):
		var Stats = area.get_parent()
		knockback = Stats.direction * Stats.KBIntensity
		knockback_timer = Stats.KBTime
		Hp -= Stats.damage
		Health_bar.health_change(-Stats.damage)
		if Hp <= 0:
			on_death()
		if area.is_in_group("Enemy_attacks"):
			Stats.queue_free()
	if area.is_in_group("Wind") and area.is_in_group("Player_attacks"):
		var Stats = area.get_parent()
		Stats = area.get_parent().SPC
		knockback = ArrDir * Stats.KBIntensity * 5
		knockback_timer = Stats.KBTime * 1.5
		Stats.get_parent().queue_free()


func on_set_vars() -> void:
	var Thing = $CanvasLayer3/Control/HBoxContainer
	Thingy1 = Thing.SPs[0]
	Thingy2 = Thing.SPs[1]
	Thingy3 = Thing.SPs[2]
	Thingy4 = Thing.SPs[3]


func _on_restart_time_timeout() -> void:
	get_tree().reload_current_scene()


func _on_button_pressed() -> void:
	$CanvasLayer3.visible = not $CanvasLayer3.visible
	if $CanvasLayer3.visible == true:
		Engine.time_scale = 0.2
		Severed_universe = true
	elif $CanvasLayer3.visible == false:
		Engine.time_scale = 1.0
		Severed_universe = false
	
