extends Node

func _process(delta):
	if (Input.is_action_pressed("exit")):
		get_tree().quit()
