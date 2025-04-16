extends Node

var dialogue_index = 0
var dialogue_lines = ['It was just another morning at Rune Academy...', 'Until the sky cracked open and magic trembled.', 'The teachers vanished. Spells misfired. Chaos bloomed.', "Now, it's up to me—The Weaver—to climb the Spire and restore balance."]

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