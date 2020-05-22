extends Control

export (PackedScene) var game

func _ready():
	global.restart_stats()
	global.load_game()
	if get_tree().paused:
		global.get_node("music").play()
		get_tree().paused = false
	if global.record.size() > 0:
		$record.set_text("Max record: Saves: " + str(global.record[0]) + ", Deaths: " + str(global.record[1]))

func _on_credits_pressed():
	#global.transition_game()
	pass # replace with function body

func start_game(scene, mode):
	global.mode = mode
	global.transition_game(scene)
	global.can_pause = true

func _on_normal_button_up():
	start_game(game, "normal")

func _on_noob_button_up():
	start_game(game, "easy")

func _on_hard_button_up():
	start_game(game, "hard")
