extends Area2D

@export var rune_type: String
var is_selected = false
var is_dragging = false

signal piece_selected(rune_type)

func _ready():
    set_process_input(true)
    connect("input_event", self, "_on_input_event")

func _input(event):
    if is_dragging and event is InputEventMouseMotion:
        global_position += event.relative

func _on_input_event(viewport, event, shape_idx):
    if event is InputEventMouseButton:
        if event.button_index == BUTTON_LEFT:
            if event.pressed:
                is_dragging = true
                is_selected = true
                emit_signal("piece_selected", rune_type)
                update_visual()
            else:
                is_dragging = false

func update_visual():
    $Sprite.modulate = Color(1, 1, 1) if is_selected else Color(0.7, 0.7, 0.7)
    if has_node("AnimationPlayer"):
        $AnimationPlayer.play("select")