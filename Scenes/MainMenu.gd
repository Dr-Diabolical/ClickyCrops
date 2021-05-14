extends Control

func _on_ButtonPlay_pressed():
	get_tree().change_scene("res://Scenes/Game.tscn")

func _on_ButtonExit_pressed():
	get_tree().quit()
