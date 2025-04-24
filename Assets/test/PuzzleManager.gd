extends Node

var selected_runes := []

func _ready():
	for piece in $PuzzleGrid.get_children():
		piece.connect("piece_selected", self, "_on_piece_selected")

func _on_piece_selected(rune_type):
	if rune_type in selected_runes:
		selected_runes.erase(rune_type)
	else:
		selected_runes.append(rune_type)

	if selected_runes.size() == 3:
		check_rune_combo()

func check_rune_combo():
	if selected_runes == ["fire", "earth", "air"]:
		print("Rune combo success! Rewarding player...")
		if has_node("SuccessPopup"):
			$SuccessPopup.show()
	else:
		print("Invalid rune combo.")
		if has_node("FailPopup"):
			$FailPopup.show()
	selected_runes.clear()
