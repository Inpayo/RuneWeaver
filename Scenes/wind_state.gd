extends CharacterBody2D

enum States {Dash, Hover}
var state = States.Hover

var HoverSep := 100
var HoverSepV := 50
var HoverSp := 2.0
var HoverAmp := 20
var HoverAng := 0.0

var player: Node2D

var Dash_points = []
var num_points = 0
var CurrentDashTarget := 0
var DashSpeed := 2000
var Dashing := false

func _ready() -> void:
	player = get_parent().get_node("Player")

func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	match state:
		States.Hover:
			$MovingSpr.visible = true
			$MovingHBox.disabled = false
			$AttackingSpr.visible = false
			$AttackingSpr/Area2D/CollisionShape2D.disabled = true
			HoverNearPlayer(delta)
			if $HoverDur.is_stopped() and !Dashing:
				$HoverDur.start()
				
		States.Dash:
			$MovingSpr.visible = false
			$MovingHBox.disabled = true
			$AttackingSpr.visible = true
			$AttackingSpr/Area2D/CollisionShape2D.disabled = false
			Dash(delta)
	
func GetHoverPos(delta: float) -> Vector2:
	HoverAng += HoverSp * delta
	var BaseRad = HoverSep + sin(Time.get_ticks_msec()/500.0) * HoverSepV
	var Offset = Vector2.RIGHT.rotated(HoverAng) * BaseRad
	Offset.y += sin(Time.get_ticks_msec()/300.0) * HoverAmp
	return player.global_position + Offset
	
func HoverNearPlayer(delta):
	var HoverPos = GetHoverPos(delta)
	var dir = (HoverPos - global_position).normalized()
	velocity = dir * 300
	move_and_slide()
	
func StartDashing():
	Dash_points.clear()
	num_points = randi_range(4,10)
	CurrentDashTarget = 0
	Dashing = true
	
func Dash(delta):
	
	if Dashing:
		if not has_meta("current_target"):
			var offset	 = Vector2(randf_range(-300, 300), randf_range(-200, 200))
			var new_target = player.global_position + offset
			set_meta("current_target", new_target)
		var target = get_meta("current_target")
		var direction = (target - global_position).normalized()
		velocity = direction * DashSpeed
		move_and_slide()
		
		if global_position.distance_to(target) < 20:
			CurrentDashTarget += 1
			if CurrentDashTarget >= num_points:
				velocity = Vector2.ZERO
				Dashing = false
				state = States.Hover
				remove_meta("current_target")
			else:
				remove_meta("current_target")
		
		
func _on_hover_dur_timeout() -> void:
	StartDashing()
	state = States.Dash
