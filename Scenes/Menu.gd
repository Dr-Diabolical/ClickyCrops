# Menu.gd
# Handles the display of the in-game menu, called on when the player presses
# Q on their keyboard
# Last modified: 10-12-2021

extends Control

signal exit(save_game)

# Toggles the visibility of the menu
func toggle_menu():
	if (not self.is_visible_in_tree()):
		self.show()
	else:
		self.hide()

func _on_SaveExitButton_pressed():
	emit_signal("exit", true)

func _on_ExitButton_pressed():
	emit_signal("exit", false)
