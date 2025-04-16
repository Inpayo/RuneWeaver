extends Node

var dialogue_index = 0
var dialogue_lines = ['The air burns. The rocks crackle.', 'This place tests every step, every spell.', 'Wait... a vision?', 'Others have climbed before me—braver, stronger—but none returned.']

func _ready():
	show_dialogue(dialogue_lines)

func show_dialogue(lines):
	dialogue_index = 0
	dialogue_lines = lines
	$DialogueBox.visible = true
	$DialogueBox/Label.text = dialogue_lines[dialogue_index]

func _on_DialogueBox_pressed():
	dialogue_index += 1
	if dialogue_index < dialogue_lines.size():
		$DialogueBox/Label.text = dialogue_lines[dialogue_index]
	else:
		$DialogueBox.visible = false
