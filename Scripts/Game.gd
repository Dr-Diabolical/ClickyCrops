# Game.gd
# Handles the in-game menu, including exiting with and without saving game data
# Last modified: 10-12-2021

extends Node

# During the game, if the menu button is pressed, toggle display of the menu
func _process(_delta):
	if (Input.is_action_just_pressed("menu")):
		$Menu.toggle_menu()

# If the player presses save and exit, save the farm data and exit,
# if the player presses exit, exit without saving
func _on_Menu_exit(save_game):
	if (save_game == true):
		$Farm.save_data()
		get_tree().quit()
	else:
		get_tree().quit()
