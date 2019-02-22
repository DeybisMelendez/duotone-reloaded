extends Area2D

var checkpoint = false

func _ready():
	if global.mode == "normal":
		queue_free()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_checkpoint_body_entered(body):
	pass # replace with function body
