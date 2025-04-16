extends Node

var dialogue_index = 0
var dialogue_lines = ['The Spire is whole again. Magic flows calmly.', 'The Weaver is no longer an apprentice.', 'I’ve seen the cost of power. I’ve seen hope born from ruin.', 'The world will remember this climb. And so will I.']

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