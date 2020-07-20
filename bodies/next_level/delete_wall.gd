extends StaticBody2D


func _physics_process(delta):
	if get_tree().get_nodes_in_group("moneda").size() == 0:
		global.get_node("explosion").play()
		queue_free()
