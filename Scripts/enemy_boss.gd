extends CharacterBody2D

enum States {Dash, Hover}
var state = States.Hover
var dead: bool = false
var player_detected: bool = false
@onready var direction: Vector2 = (player.global_position - global_position).normalized()
var knockback: Vector2 = Vector2.ZERO
var knockback_timer: float = 0.0
var weakness = "Physical"
var KBIntensity = 600
var KBTime = 0.12
var damage = 10

@export var max_Hp = 1000
@onready var Hp = max_Hp
@export var Active: bool = true

@export var player: Node
@export var wind: Node
@export var fire: Node
@export var rock: Node
@export var ice: Node

@onready var elemental_array = [wind,fire,rock,ice]


@onready var Element = ice
@onready var Dashing = false

func _ready() -> void:
	$DashDur.stop()

func _physics_process(delta: float) -> void:
	print(Active)
	if Active:
		direction = (player.global_position - global_position).normalized()
		if direction.x < 0:
			$AttackingSpr.flip_h = true
		else:
			$AttackingSpr.flip_h = false
		
		if knockback_timer > 0.0:
			global_position += knockback 
			knockback_timer -= delta
			if knockback_timer <= 0.0:
				knockback = Vector2.ZERO
		
			
		if knockback_timer <= 0.0:
			match state:
				States.Hover:
					$MovingSpr.visible = true
					$MovingHBox.disabled = false
					$AttackingSpr.visible = false
					$AttackingSpr/Area2D/CollisionShape2D.disabled = true
					Element.HoverNearPlayer(delta)
					if $HoverDur.is_stopped() and not Element.Dashing:
						$HoverDur.start(Element.time)
						
				States.Dash:
					$MovingSpr.visible = false
					$MovingHBox.disabled = true
					$AttackingSpr.visible = true
					$AttackingSpr/Area2D/CollisionShape2D.disabled = false
					Element.Dash(delta)

func _on_hover_dur_timeout() -> void:
	Element.StartDashing()
	state = States.Dash
	$DashDur.start()

func Knockback(knockback_intensity, time, KBDir):
	knockback = KBDir * knockback_intensity / 30
	knockback_timer = time

func element_change(number) -> void:
		var x: int = number/(max_Hp/5)
		x = clamp(x, 1, 4) - 1
		Element = elemental_array[x]
		$MovingSpr.frame_coords.x = 3-x
		$AttackingSpr.frame_coords.x = 3-x
		Element.Dashing = false
		state = States.Hover

		
func received_damage(damage: int):
	Hp -= damage * Element.multiplier(weakness)
	element_change(Hp)
	if Hp <= 0:
			on_death()
	if Element == wind:
		Element.Dashing = false
		state = States.Hover
		
func on_death():
	queue_free()

func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player_attacks"):
		var Stats = area.get_parent()
		if area.is_in_group("Special_proj"):
			Stats = area.get_parent().SPC
		received_damage(Stats.damage)
		var KBDir = Stats.direction
		Knockback(Stats.KBIntensity, Stats.KBTime, KBDir)
		Stats = area.get_parent()
		if area.is_in_group("Special_proj"):
			Stats.KYS()
			pass
		if area.is_in_group("Player_attacks"):
			Stats.queue_free()
		weakness = Stats.element
		


func _on_dash_dur_timeout() -> void:
	if Element.Dashing and Element.Melee:
		print("activate")
		Element.Dashing = false
		state = States.Hover


func _on_boss_area_body_entered(_body: Node2D) -> void:
	Active = true
