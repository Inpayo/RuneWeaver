extends Area2D

@onready var entity: CharacterBody2D = $".."

func received_damage(value):
	entity.received_damage(value)
