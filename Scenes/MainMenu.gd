extends Control

# On button press, load the game scene
func _on_ButtonPlay_pressed():
	get_tree().change_scene("res://Scenes/Game.tscn")

# On button press, exit the game
func _on_ButtonExit_pressed():
	get_tree().quit()
