extends Node2D

var speed = 0
var damage = 0
var KBIntensity = 0
var KBTime = 0.16
var Box
var Mid
var direction
var last_location
@onready var init_location = get_parent().position

var Vars = ["Wind", "Blast","Power", "None"]

func Cast(Damage, Knockback, DOT, EffTim, SPRed, Sprite, Speed, Aug1Dam, Aug1Spd, Aug1CT, Aug1KB, AugS1, Aug2Dam, Aug2Spd, Aug2CT, Aug2KB, AugS2):
	var Mid = get_parent().get_node("Hurtbox/CollisionShape2D")
	var Tempbox = Mid.shape                                       
	Mid.shape = Tempbox.duplicate()                           
	Box = Mid.shape  
	var target_size = Vector2(132, 132)
	
	
	if "Move" in Vars:
		$Mana_req2.wait_time += Aug1CT + Aug2CT
		$Mana_req2.start()
		await $Mana_req2.timeout
		
	speed = Speed * (1 + Aug1Spd + Aug2Spd)
	damage = Damage * (1 + Aug1Dam + Aug2Dam)
	
	if Knockback == 0 and "Knockback" in Vars:
		Knockback = 100
	
	KBIntensity = Knockback * (1 + Aug1KB + Aug2KB)
	var BScale = target_size/Vector2(Box.radius * 2, Box.height + Box.radius * 2)/2
	var tex = load(Sprite)
	self.texture = tex
	var scale_factor = target_size / tex.get_size()
	BScale *= (1 + AugS1 + AugS2)
	scale_factor *= (1 + AugS1 + AugS2)
	self.scale = scale_factor
	Box.radius *= BScale.x
	Box.height *= BScale.y
	
	
	
func _physics_process(delta: float) -> void:
	get_parent().position += Vector2.RIGHT.rotated(get_parent().rotation) * speed * delta
	last_location = get_parent().position
	direction = (last_location - init_location).normalized()
