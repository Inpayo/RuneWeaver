extends CharacterBody2D

enum States {Dash, Hover}
var state = States.Hover
var dead: bool = false
var player_detected: bool = false
@onready var direction: Vector2 = position.direction_to(player.position)
var knockback: Vector2 = Vector2.ZERO
var knockback_timer: float = 0.0

var hurt = 0

@export var player: Node
@export var wind: Node
@export var fire: Node
@export var rock: Node
@export var ice: Node

@onready var elemental_array = [wind,rock]


@onready var Element = wind
@onready var Dashing = false


func _physics_process(delta: float) -> void:

	if knockback_timer > 0.0:
		print(knockback)
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
					$HoverDur.start()
					
			States.Dash:
				$MovingSpr.visible = false
				$MovingHBox.disabled = true
				$AttackingSpr.visible = true
				$AttackingSpr/Area2D/CollisionShape2D.disabled = false
				Element.Dash(delta)

func _on_hover_dur_timeout() -> void:
	Element.StartDashing()
	state = States.Dash

func Knockback(knockback_intensity, time, KBDir):
	knockback = KBDir * knockback_intensity / 30
	knockback_timer = time

func element_change(number) -> void:
	@warning_ignore("integer_division") var x: int = number/30
	Element = elemental_array[x]
	
func received_damage(damage: int):
	hurt += damage
	element_change(hurt)

func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player_attacks"):
		var Stats = area.get_parent()
		if area.is_in_group("Special_proj"):
			Stats = area.get_parent().SPC
		received_damage(Stats.damage)
		var KBDir = Stats.direction
		print(KBDir)
		Knockback(Stats.KBIntensity, Stats.KBTime, KBDir)
		Stats = area.get_parent()
		if area.is_in_group("Special_proj"):
			Stats.KYS()
			pass
		if area.is_in_group("Player_attacks"):
			Stats.queue_free()
