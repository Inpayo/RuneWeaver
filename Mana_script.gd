extends Node

signal Ready

func _ready() -> void:
	emit_signal("Ready")
