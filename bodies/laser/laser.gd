extends Area2D


var encenderLaser = false

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body.morir()

func _on_Timer_timeout():
	if encenderLaser:
		encenderLaser = false
		$AnimationPlayer.play("encendido")
	else:
		encenderLaser = true
		$AnimationPlayer.play("apagado")
