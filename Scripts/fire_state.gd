extends Node2D

const bullet_scene = preload("res://Scenes/dark_flames.tscn")
enum States {Dash, Hover}
var state = States.Hover

var time = 2.5
var Melee = false
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
	Dashing = true
	
func multiplier(type):
	if type == "Wind":
		return 2
	else:
		return 1
func Dash(delta):
	
	if Dashing:

		var bullet = bullet_scene.instantiate()
		bullet.position = position 
		bullet.rotation = (player.global_position - global_position).angle()
		
		get_parent().add_child(bullet)
		
		Dashing = false
		boss.state = States.Hover
	


		
