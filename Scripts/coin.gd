extends Area2D


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sound: AudioStreamPlayer2D = $"Pick up SFX"

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		sound.play()
		await get_tree().create_timer(0.2).timeout
		sound.stream_paused = true
		
		queue_free()
