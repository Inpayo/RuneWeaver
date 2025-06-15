extends StaticBody2D

@export var barrier = Node

func _ready() -> void:
	$crystal_sprite.frame_coords.y = 0
	
func crystal_break() -> void:
	$crystal_sprite.frame_coords.y = 1
	barrier.barrier()
	

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player_attacks"):
		crystal_break()

		var Stats = area.get_parent()
		Stats.queue_free()
			
		
