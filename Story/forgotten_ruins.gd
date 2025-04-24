extends Node

var dialogue_index = 0
var dialogue_lines = ['These ruins whisper secrets... illusions trying to block my path.', '‘The Council’s ambition will doom us all,’ says an old inscription.', 'Did they cause the explosion? Were the Rune Cores experiments?', 'This wasn’t an accident. It was power. Greed. Control.']

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
