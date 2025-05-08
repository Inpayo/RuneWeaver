extends Node2D

var speed = 0
var damage = 0
var knockback = 0

var Vars = ["Fire", "Move"]

func Cast(Damage, Knockback, Sprite, Speed):
	speed = Speed
	damage = Damage
	knockback = Knockback
	$Sprite2D.texture = load(Sprite)
	
	
func _physics_process(delta: float) -> void:
	position += Vector2.RIGHT.rotated(rotation) * speed * delta
