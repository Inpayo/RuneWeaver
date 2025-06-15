extends Control


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/diary.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_controls_pressed() -> void:
	$TheControls.visible = not $TheControls.visible
