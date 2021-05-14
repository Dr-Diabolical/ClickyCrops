extends Control

onready var button_carrot = $HBox/ButtonCarrot
onready var button_potato = $HBox/ButtonPotato

func _ready():
	self.hide()
		
func toggle_shop():
	if (not self.is_visible_in_tree()):
		self.show()
	else:
		self.hide()

func _on_ShopButton_pressed():
	toggle_shop()
