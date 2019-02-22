extends Area2D

func _on_moneda_body_entered(body):
	if body.is_in_group("player"):
		global.get_node("coin").play()
		body.coins_taken.append(get_name())
		queue_free()