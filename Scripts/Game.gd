extends Node

# During game, if the user presses the exit action, exit the game
func _process(_delta):
	if (Input.is_action_just_pressed("menu")):
		$Menu.toggle_menu()

func _on_Menu_exit(save_game):
	if (save_game == true):
		$Farm.save_data()
		get_tree().quit()
	else:
		get_tree().quit()
