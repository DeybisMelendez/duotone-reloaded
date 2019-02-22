extends Control
var menu = load ("res://scenes/ui/menu.tscn")
func _ready():
	global.can_pause = false
	$CenterContainer/VBoxContainer/record.set_text("Saves: " + str(global.saves_count) + ", Deaths: " + str(global.deads))
	if global.record.size() > 0:
		if global.saves_count < global.record[0]:
			global.save_game()
		elif global.saves_count == global.record[0]:
			if global.deads < global.record[1]:
				global.save_game()
	else:
		global.save_game()
func _on_TextureButton_pressed():
	global.transition_game(menu)