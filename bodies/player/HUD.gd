extends CanvasLayer

var coins = 0
var show = false

func _ready():
#	if !OS.has_touchscreen_ui_hint(): #Eliminamos el boton pausa si no tiene touchscreen
#		$pause.hide()
	$Label.hide()
	if global.mode != "easy":
		$HBoxContainer/saves.queue_free()
		#$HBoxContainer/MarginContainer.queue_free()
		$save_pos.queue_free()
		if global.mode == "hard":
			$HBoxContainer/deads.queue_free()
	if get_tree().paused:
		global.pause_game()

func _process(delta):
	coins = global.coins - get_tree().get_nodes_in_group("moneda").size()
	$HBoxContainer/level.set_text("Level: " + get_tree().get_current_scene().get_name())
	$HBoxContainer/coins.set_text("Coins: " + str(coins) + "/" + str(global.coins))
	if global.mode != "hard":
		$HBoxContainer/deads.set_text("Deaths: " + str(global.deads))
	if global.mode == "easy":
		$HBoxContainer/saves.set_text("Saves: " + str(global.saves_count))
		if Input.is_action_just_pressed("save_position") and get_parent().can_save:
			global.spawn_position = get_parent().global_position
			$Label.show()
			$Timer.start()
			global.saves_count += 1
			for coin in get_parent().coins_taken:
				if !global.coins_taken.has(coin):
					global.coins_taken.append(coin)
	# Muestra el menu pausa
	if get_tree().paused and !show:
		$Popup.show()
		show = true
	elif !get_tree().paused and show:
		$Popup.hide()
		show = false

func _on_Timer_timeout():
	$Label.hide()

func _on_menu_button_up():
	var menu = load("res://scenes/main/Main.tscn")
	global.transition_game(menu)
	global.restart_stats()
	global.can_pause = false

func _on_exit_button_up():
	get_tree().quit()

func _on_pause_button_up():
	global.pause_game()
	hide_and_show("hide")


func _on_resume_button_up():
	global.pause_game()
	hide_and_show("show")

func hide_and_show(to_do): #Control del jugador
	match to_do:
		"hide":
			$pause.hide()
			$right.hide()
			$left.hide()
			$jump.hide()
			$camera.hide()
			if global.mode == "easy":
				$save_pos.hide()
		"show":
			$pause.show()
			$right.show()
			$left.show()
			$jump.show()
			$camera.show()
			if global.mode == "easy":
				$save_pos.show()

func _on_restart_button_up():
	if !get_parent().death:
		get_parent().morir()
	global.coins_taken = []
	global.spawn_position = null
	global.pause_game()

func _input(event):
	if Input.is_action_just_pressed("pause") and global.can_pause:
		if get_tree().paused:
			_on_resume_button_up()
		else:
			_on_pause_button_up()
