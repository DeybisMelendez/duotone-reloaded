extends KinematicBody2D

const gravity = 20
var speed = 150
var dir = 0 # Direccion
var mov = Vector2() #Movimiento
var jump = 350
var anim = ""
var new_anim = ""
var death = false
var coins_taken = []
var can_save = true

func _ready():
	global.can_pause = true
	if global.spawn_position != null:
		global_position = global.spawn_position
		var level_coins = get_tree().get_nodes_in_group("moneda")
		for coin in level_coins:
			if global.coins_taken.has(coin.get_name()):
				coin.queue_free()
func _physics_process(delta):	
	# Movimiento
	mov.y += gravity
	mov.y = clamp(mov.y, -jump, jump)
	mov.x = dir * speed
	
	if !death:
		mov = move_and_slide(mov , Vector2(0, -1))
		button_control()
	
	#Animacion
	if is_on_floor():
		if dir == 0:
			new_anim = "idle"
		else:
			new_anim = "running"
	else:
		new_anim = "jump"
	
	if anim != new_anim:
		anim = new_anim
		$anim.play(anim)
		if dir == 0:
			$Sprite.flip_h = !$Sprite.flip_h #La animacion original de parado esta volteada, con esto se reparo

func morir():
	can_save = false
	global.get_node("hit").play()
	global.deads += 1
	$Sprite.hide()
	$Particles2D.set_emitting(true)
	death = true
	$Timer.start()

func button_control():
	if Input.is_action_just_pressed("change_camera"):
		if $Camera2D.is_current():
			$Camera2D._set_current(false)
			get_parent().get_node("Camera2D")._set_current(true)
		else:
			$Camera2D._set_current(true)
			get_parent().get_node("Camera2D")._set_current(false)
	if Input.is_action_pressed("right"):
		dir = 1
		$Sprite.flip_h = false
	elif Input.is_action_pressed("left"):
		dir = -1
		$Sprite.flip_h = true
	else:
		dir = 0
	if Input.is_action_just_pressed("jump") and is_on_floor():
		mov.y -= jump
		global.get_node("jump").play()

func _on_Timer_timeout():
	if global.mode != "hard":
		global.transition_reload()
	else:
		var menu = load("res://scenes/levels/start.tscn")
		#global.restart_stats()
		global.transition_game(menu)
