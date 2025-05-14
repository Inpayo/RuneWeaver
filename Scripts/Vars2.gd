extends Node2D

var speed = 0
var damage = 0
var knockback = 0

var Vars =  ["Wind", "No_move"]

func Cast(Damage, Knockback, Sprite, Speed):
	speed = Speed
	damage = Damage
	knockback = Knockback
	self.texture = load(Sprite)
	var tex = load(Sprite)
	self.texture = tex
	var target_size = Vector2(64, 64)
	var scale_factor = target_size / tex.get_size()
	self.scale = scale_factor
	
func _physics_process(delta: float) -> void:
	position += Vector2.RIGHT.rotated(rotation) * speed * delta
