extends CharacterBody2D

var Chasing := false
var damage := 10

func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	pass
	
func _on_detection_body_entered(body: Node2D) -> void:
	Chasing = true
	
func _on_detection_body_exited(body: Node2D) -> void:
	Chasing = false
	
func update_element():
	pass
