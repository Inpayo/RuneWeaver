extends CharacterBody2D

const bullet_scene = preload("res://Scenes/bullet.tscn")
const coin_scene = preload("res://Scenes/coin.tscn")

@export var speed: float = 300.0
@export var Hp: int = 20
var last_location = null
var dead: bool = false
var player_detected: bool = false
var player_in_range: bool = false
var direction: Vector2 = Vector2.ZERO
var player
var knockback: Vector2 = Vector2.ZERO
var knockback_timer: float = 0.0
var on_cd: bool = false
@export var cd_duration: float = 2.0 
@onready var mark: Marker2D = $Sprite2D/Marker2D


func _ready():
	dead = false
	$shoot_cd.wait_time = cd_duration
	
func _physics_process(_delta):
		
	if not dead:
		$Player_detection/Detection.disabled = false
		
		if direction != Vector2.ZERO:
			$Sprite2D/AnimationPlayer.play("Fly")
		else:
			$Sprite2D/AnimationPlayer.play("idle")
			
		if direction.x > 0:
			$Sprite2D.flip_h = true
			$Sprite2D/Marker2D.position.x = 76

		elif direction.x < 0:
			$Sprite2D.flip_h = false
			$Sprite2D/Marker2D.position.x = -76

		

		
		if player_in_range:
			if not on_cd:
				shoot()
				on_cd = true
				$shoot_cd.start()
		if knockback_timer > 0.0:
			velocity = knockback
			knockback_timer -= _delta
			if knockback_timer <= 0.0:
				knockback = Vector2.ZERO
		
		elif player_detected and knockback_timer <= 0.0:
			direction = position.direction_to(player.position)
			velocity = direction * speed * _delta * 50 * -1
		else:
			velocity = Vector2.ZERO

	else:
		$Player_detection/Detection.disabled = true
	move_and_slide()

func received_damage(damage):
	Hp -= damage
	if Hp <= 0:
		on_death()

func on_death():
	dead = true
	loot()

	$Sprite2D/AnimationPlayer.play("death")
	await $Sprite2D/AnimationPlayer.animation_finished
	velocity = Vector2.ZERO
	$Hitbox/CollisionShape2D.disabled = true
	$death_timer.start()

func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_detected = true
		player = body

func _on_player_detection_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_detected = false

func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.position = mark.global_position
	bullet.rotation = (player.position - position).angle()
	get_parent().add_child(bullet)

func loot():
	for n in range(3):
		var loot = coin_scene.instantiate()
		loot.position.x = position.x + randf_range(50.0, 100.0)
		loot.position.y = position.y + randf_range(50.0, 100.0)
		get_parent().add_child(loot)
	

func apply_knockback(knockback_direction: Vector2, intensity: float, time: float) -> void:
	print(knockback_direction, intensity, time)
	knockback = knockback_direction * intensity
	knockback_timer = time
	print(knockback, knockback_timer)


func _on_attack_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_range = true
		player = body


func _on_attack_range_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_range = false


func _on_shoot_cd_timeout() -> void:
	on_cd = false
	

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player") or area.is_in_group("Player_attacks"):
		var Stats = area.get_parent()
		if area.is_in_group("Special_proj"):
			Stats = area.get_parent().SPC
		received_damage(Stats.damage)
		var KBDir = (area.position - position).normalized()
		apply_knockback(KBDir, Stats.KBIntensity, Stats.KBTime )
		Stats = area.get_parent()
		if area.is_in_group("Special_proj"):
			Stats.KYS()
			pass
		if area.is_in_group("Player_attacks"):
			Stats.queue_free()

func _on_death_timer_timeout() -> void:
	queue_free()
