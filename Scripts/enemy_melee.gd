extends CharacterBody2D

@export var speed: float = 500.0
@export var Hp: int = 20
var last_location = null
var dead: bool = false
var player_detected: bool = false
var direction: Vector2 = Vector2.ZERO
var player
var knockback: Vector2 = Vector2.ZERO
var knockback_timer: float = 0.0
var Delta
@export var weakness: String = "none"
var damage_type

var KBIntensity = 600
var KBTime = 0.12
var damage = 10

func _ready():
	dead = false
	
func _physics_process(_delta):
		
	if not dead:
		$Player_detection/Detection.disabled = false
		
		if not velocity:
			$Sprite2D/AnimationPlayer.play("idle")
		else:
			$Sprite2D/AnimationPlayer.play("Fly")
			
		if direction.x > 0:
			$Sprite2D.flip_h = true
			$Sprite2D.offset.x = -48.0
		elif direction.x < 0:
			$Sprite2D.flip_h = false
			$Sprite2D.offset.x = 0
		
		if knockback_timer > 0.0:
			velocity = knockback 
			if direction == Vector2.ZERO:
				velocity -= velocity * 3 ** 2 * _delta
			else:
				velocity -= velocity * 3 * _delta
			knockback_timer -= _delta
			if knockback_timer <= 0.0:
				knockback = Vector2.ZERO
				
		elif player_detected and knockback_timer <= 0.0:
			direction = position.direction_to(player.position)
			velocity = direction * speed * _delta * 50 
		elif not player_detected and last_location != null:
			direction = position.direction_to(last_location)
			velocity = direction * speed * _delta * 50
			if not (last_location - position).x > 100 and not (last_location - position).x < -100 and not (last_location - position).y > 100 and not (last_location - position).y < -100:
				velocity = Vector2.ZERO
				last_location = null
		elif not player_detected and last_location == null:
			velocity = Vector2.ZERO

	else:
		$Player_detection/Detection.disabled = true
	move_and_slide()

func received_damage(damage: int):
	print(damage)
	Hp -= damage * multiplier(damage_type)
	if Hp <= 0:
		on_death()
func multiplier(type):
	if type == weakness:
		return 2
	else:
		return 1

func on_death():
	dead = true
	queue_free()

func Knockback(knockback_intensity, time, KBDir):
	knockback = KBDir * knockback_intensity 
	knockback_timer = time
	
func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player") or area.is_in_group("Player_attacks"):
		var Stats = area.get_parent()
		if area.is_in_group("Special_proj"):
			Stats = area.get_parent().SPC
		var KBDir = Stats.direction
		var damage_done = Stats.damage
		Knockback(Stats.KBIntensity, Stats.KBTime, KBDir)
		Stats = area.get_parent()
		if area.is_in_group("Special_proj"):
			Stats.KYS()
			pass
		if area.is_in_group("Player_attacks"):
			received_damage(damage_done)
			damage_type = Stats.element
			Stats.queue_free()


func _on_player_detection_body_entered(body):
	if body.is_in_group("Player"):
		player_detected = true
		player = body

func _on_player_detection_body_exited(body) :
	if body.is_in_group("Player"):
		player_detected = false
		last_location = player.position
