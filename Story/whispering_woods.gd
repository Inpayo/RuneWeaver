extends Node

var dialogue_index = 0
var dialogue_lines = ['These woods... I used to play here.', 'Now the trees groan in pain, and the animals attack.', 'Something dark has poisoned the heart of the forest.', "The first Rune Core... it's shattered, pulsing with tainted energy."]

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