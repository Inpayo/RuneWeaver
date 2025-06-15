extends StaticBody2D


@export var active: bool = true

func _ready() -> void:
	$Sprite2D.visible = active
	$CollisionShape2D.disabled = not active

func collide():
	$"../barierG/Timer".start()
	

func barrier():
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	$Sprite2D.visible = true
	collide()

func _on_timer_timeout() -> void:
	$CollisionShape2D.disabled = false
