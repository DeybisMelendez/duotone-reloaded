extends CanvasLayer

var deads = 0
var mode = "easy"
var coins = 0
var can_pause = false
var spawn_position = null
var coins_taken = []
var saves_count = 0
var record = []

#func _input(event):
#	if Input.is_action_just_pressed("pause") and can_pause:
#		pause_game()

func pause_game():
		if get_tree().paused:
			$music.set_volume_db(0)
			get_tree().paused = false
		else:
			get_tree().paused = true
			$music.set_volume_db(-20)

func transition_game(scene):
	$transition.play("fade_out")
	yield($transition,"animation_finished")
	get_tree().change_scene_to(scene)
	$transition.play("fade_in")
	$music.set_volume_db(0)

func transition_reload():
	$transition.play("fade_out")
	yield($transition,"animation_finished")
	get_tree().reload_current_scene()
	$transition.play("fade_in")
	$music.set_volume_db(0)
func restart_stats():
		deads = 0
		coins = 0
		spawn_position = null
		saves_count = 0
		coins_taken = []

func save_game():
	var file = File.new()
	file.open("user://data.dat", file.WRITE)
	file.store_var(saves_count)
	file.store_var(deads)
	file.close()

func load_game():
	record = []
	var file = File.new()
	if !file.file_exists("user://data.dat"):
		return
	file.open("user://data.dat", file.READ)
	record.append(file.get_var())
	record.append(file.get_var())
	file.close()
