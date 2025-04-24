extends Node2D

signal rune_drawn(rune_name)
var drawing = false
var points = []

func _input(event):
    if event is InputEventMouseButton:
        if event.button_index == BUTTON_LEFT:
            drawing = event.pressed
            if not drawing:
                detect_rune(points)
                points.clear()
    elif event is InputEventMouseMotion and drawing:
        points.append(event.position)
        update()

func _draw():
    for i in range(points.size() - 1):
        draw_line(points[i], points[i + 1], Color(1, 0.8, 0.2), 2)

func detect_rune(points):
    if points.size() > 10:
        emit_signal("rune_drawn", "mock_rune")