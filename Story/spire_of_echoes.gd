extends Node

var dialogue_index = 0
var dialogue_lines = ['Time flickers. My footsteps echo twice.', "At the summit... my mentor. But something's wrong.", 'Corruption has claimed their soul.', 'To fix the final Rune Core, I must fight... them—and myself.']

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