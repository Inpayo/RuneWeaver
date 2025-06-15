extends Node2D

enum States {Dash, Hover}
var state = States.Hover

var time = 3.0
var Melee = true
var HoverSep := 50
var HoverSepV := 50
var HoverSp := 1.0
var HoverAmp := 10
var HoverAng := 0.0

@export var player: Node
@export var boss: Node

var Dash_points = []
var num_points = 0
var CurrentDashTarget := 0
var DashSpeed := 2000
var Dashing := false

func multiplier(type):
	if type == "Ice":
		return 2
	else:
		return 1
	
func GetHoverPos(delta: float) -> Vector2:
	HoverAng += HoverSp * delta
	var BaseRad = HoverSep + sin(Time.get_ticks_msec()/500.0) * HoverSepV
	var Offset = Vector2.RIGHT.rotated(HoverAng) * BaseRad
	Offset.y += sin(Time.get_ticks_msec()/300.0) * HoverAmp
	return player.global_position + Offset
	
func HoverNearPlayer(delta):
	var HoverPos = GetHoverPos(delta)
	var dir = (HoverPos - global_position).normalized()
	boss.velocity = dir * 100
	boss.move_and_slide()
	
func StartDashing():
	print("Rock & Roll")
	Dash_points.clear()
	num_points = 1
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
		boss.velocity = direction * DashSpeed
		boss.move_and_slide()
		
		if global_position.distance_to(target) < 20:
			CurrentDashTarget += 1
			if CurrentDashTarget >= num_points:
				boss.velocity = Vector2.ZERO
				Dashing = false
				boss.state = States.Hover
				remove_meta("current_target")
			else:
				remove_meta("current_target")
	


		
