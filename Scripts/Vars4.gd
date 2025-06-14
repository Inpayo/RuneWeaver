extends Node2D

@onready var element = Vars[0]
var speed = 0
var damage = 0
var KBIntensity = 0
var KBTime = 0.16
var Box
var Mid

@onready var direction = Vector2.from_angle(get_parent().rotation)

var CD_Dur


var Vars = [null, null, null, null]


func Cast(Damage, Knockback, DOT, EffTim, SPRed, Sprite, Speed, Aug1Dam, Aug1Spd, Aug1CT, Aug1KB, AugS1, Aug2Dam, Aug2Spd, Aug2CT, Aug2KB, AugS2):
	var Mid = get_parent().get_node("Hurtbox/CollisionShape2D")
	var Tempbox = Mid.shape                                       
	Mid.shape = Tempbox.duplicate()                           
	Box = Mid.shape  
	var target_size = Vector2(132, 132)
	
	
	CD_Dur = 2.5 * (1 + Aug1CT + Aug2CT)
		
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
