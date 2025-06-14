extends StaticBody2D

func _ready() -> void:
	$crystal_sprite.frame_coords.y = 0
	
func crystal_break() -> void:
	$crystal_sprite.frame_coords.y = 1

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player_attacks"):
		crystal_break()
		if area.is_in_group("Player_attacks"):
			var Stats = area.get_parent()
			Stats.queue_free()
		
