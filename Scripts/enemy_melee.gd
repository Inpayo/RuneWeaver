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

var KBIntensity = 200
var KBTime = 0.12
var damage = 10

func _ready():
	dead = false
	
func _physics_process(_delta):
		
	if !dead:
		Delta = _delta
		$Player_detection/Detection.disabled = false
		
		if direction != Vector2.ZERO:
			$Sprite2D/AnimationPlayer.play("Fly")
		else:
			$Sprite2D/AnimationPlayer.play("idle")
			
		if direction.x > 0:
			$Sprite2D.flip_h = true
		elif direction.x < 0:
			$Sprite2D.flip_h = false
		
		if player_detected and $KBTimer.is_stopped() == true:
			direction = position.direction_to(player.position)
			velocity = direction * speed * Delta * 50
		else:
			if last_location != null:
				direction = (last_location - position).normalized()
				velocity = direction * speed * Delta * 50
	else:
		$Player_detection/Detection.disabled = true
	move_and_slide()

func received_damage(damage: int):
	Hp -= damage
	if Hp <= 0:
		on_death()


func on_death():
	dead = true
	queue_free()

func Knockback(knockback_intensity, knockback_timer, KBDir):
	$KBTimer.start(knockback_timer)
	if $KBTimer.is_stopped():
			velocity = KBDir * knockback_intensity * Delta
			print(velocity)
	else:
		knockback = Vector2.ZERO
	
	if player_detected and $KBTimer.is_stopped() == true:
		direction = position.direction_to(player.position)
		velocity = direction * speed * Delta * 50
	else:
		if last_location != null:
			if not (last_location - position).x > 100 and not (last_location - position).x < -100 and not (last_location - position).y > 100 and not (last_location - position).y < -100:
				velocity = Vector2.ZERO
			else:
				direction = (last_location - position).normalized()
				velocity = direction * speed * Delta * 50

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player") or area.is_in_group("Player_attacks"):
		var Stats = area.get_parent()
		if area.is_in_group("Special_proj"):
			Stats = area.get_parent().SPC
		received_damage(Stats.damage)
		var KBDir = area.position - position
		Knockback(Stats.KBIntensity, Stats.KBTime, KBDir)
		Stats = area.get_parent()
		if area.is_in_group("Special_proj"):
			Stats.KYS()
			pass
		if area.is_in_group("Player_attacks"):
			Stats.queue_free()


func _on_player_detection_body_entered(body):
	if body.is_in_group("Player"):
		player_detected = true
		player = body

func _on_player_detection_body_exited(body) :
	if body.is_in_group("Player"):
		player_detected = false
		last_location = player.position
