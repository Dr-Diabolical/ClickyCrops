extends Control

# References to the shop buttons
onready var button_carrot = $HBox/ButtonCarrot
onready var button_potato = $HBox/ButtonPotato

signal buy_crop(crop_index)

# On ready, hide the shop display
func _ready():
	self.hide()

# Toggles the visibility of the shop
func toggle_shop():
	if (not self.is_visible_in_tree()):
		self.show()
	else:
		self.hide()	

# On carrots button press, emit the buy crop signal for carrots
func _on_ButtonCarrot_pressed():
	emit_signal("buy_crop", 0)

# On potatoes button press, emit the buy crop signal for potatoes
func _on_ButtonPotato_pressed():
	emit_signal("buy_crop", 1)
