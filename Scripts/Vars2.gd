extends Node2D

var speed = 0
var damage = 0
var knockback = 0

var Vars =  ["Wind", "No_move", "None", "None"]

func Cast(Damage, Knockback, Sprite, Speed, Aug1Dam, Aug1Spd, Aug1CT, Aug2Dam, Aug2Spd, Aug2CT):
	var target_size = Vector2(64, 64)
	
	$Mana_req2.wait_time += Aug1CT + Aug2CT
	if "Move" in Vars:
		$Mana_req2.start()
		await $Mana_req2.timeout
		
	speed = Speed * (1 + Aug1Spd + Aug2Spd)
	damage = Damage * (1 + Aug1Dam + Aug2Dam)
	
	knockback = Knockback
	var tex = load(Sprite)
	self.texture = tex
	var scale_factor = target_size / tex.get_size()
	self.scale = scale_factor
	
	
func _physics_process(delta: float) -> void:
	position += Vector2.RIGHT.rotated(rotation) * speed * delta
