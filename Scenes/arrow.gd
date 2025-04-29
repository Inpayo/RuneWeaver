extends Sprite2D

var DefDir = Vector2.LEFT

func _process(_delta: float) -> void:
	var Keyboard = get_parent().get_parent().Keyboard
	var pp = get_parent().global_position
	var mp = get_viewport().get_camera_2d().get_global_mouse_position()
	var direction = Vector2.ZERO
	var CDir = Input.get_vector("Aim_left", "Aim_right", "Aim_up", "Aim_down")
	var input_direction = get_parent().get_parent().input_direction
	
	if input_direction != Vector2.ZERO:
		DefDir = input_direction
	
	if Keyboard and Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
		direction = (mp - pp).normalized()
	elif !Keyboard and CDir > Vector2.ZERO:
		direction = CDir
	else:
		direction = DefDir
	
	
	position = direction * 200
	
	rotation = direction.angle()
