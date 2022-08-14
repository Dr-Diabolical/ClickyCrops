# Shop.gd
# Handles the shop, including displaying the shop and relevant data to the
# player
# Last modified: 10-12-2021

extends Control

var crop_prices = []

signal buy_crop(crop_index)

# On ready, hide the shop display
func _ready():
	self.hide()
	get_crop_prices()
	set_shop_prices()

# Toggles the visibility of the shop
func toggle_shop():
	if (not self.is_visible_in_tree()):
		self.show()
	else:
		self.hide()
		
func get_crop_prices():
	var file = File.new()
	file.open("res://Data/crops.json", file.READ)
	var text = file.get_as_text()
	file.close()
	var crop_data = parse_json(text)
	for i in crop_data.crops.size():
		crop_prices.append(crop_data.crops[i].crop_price)

func set_shop_prices():
	var text = "COST: %d"
	$HBox/Carrot/CostCarrot.text = text % crop_prices[0]
	$HBox/Potato/CostPotato.text = text % crop_prices[1]

# On carrots button press, emit the buy crop signal for carrots
func _on_ButtonCarrot_pressed():
	emit_signal("buy_crop", 0)

# On potatoes button press, emit the buy crop signal for potatoes
func _on_ButtonPotato_pressed():
	emit_signal("buy_crop", 1)
