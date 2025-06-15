extends Sprite2D

@export var boss = Node
@export var player = Node


@onready var damage = boss.damage
@onready var KBIntensity = boss.KBIntensity
@onready var KBTime = boss.KBTime
@onready var direction: Vector2 = global_position.direction_to(player.global_position) * -1

func _physics_process(delta: float) -> void:
	damage = boss.damage
	KBIntensity = boss.KBIntensity
	KBTime = boss.KBTime
	direction = global_position.direction_to(player.global_position) 
