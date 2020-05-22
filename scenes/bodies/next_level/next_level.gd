extends Area2D

export (PackedScene) var next_level

func _ready():
	global.coins = get_tree().get_nodes_in_group("moneda").size()

func _on_cambiarNivel_body_entered(body):
	if body.is_in_group("player"):
		global.spawn_position = null
		global.coins_taken = []
		get_tree().change_scene_to(next_level)
