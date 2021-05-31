extends Node

# During game, if the user presses the exit action, exit the game
func _process(_delta):
	if (Input.is_action_pressed("exit")):
		$Farm.save_data()
		get_tree().quit()
