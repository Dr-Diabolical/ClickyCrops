extends Control

# References to the shop buttons
onready var button_carrot = $HBox/ButtonCarrot
onready var button_potato = $HBox/ButtonPotato

# On ready, hide the shop display
func _ready():
	self.hide()

# Toggles the visibility of the shop
func toggle_shop():
	if (not self.is_visible_in_tree()):
		self.show()
	else:
		self.hide()	

func _on_ButtonCarrot_pressed():
	pass

func _on_ButtonPotato_pressed():
	pass
