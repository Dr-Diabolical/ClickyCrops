# MainMenu.gd
# Upon opening the game, the player is presented with two buttons to either
# play or exit. This script handles those two actions.
# Last modified: 10-12-2021

extends Control

# On button play press, load the game scene
func _on_ButtonPlay_pressed():
	get_tree().change_scene("res://Scenes/Game.tscn")

# On button exit press, exit the game
func _on_ButtonExit_pressed():
	get_tree().quit()
