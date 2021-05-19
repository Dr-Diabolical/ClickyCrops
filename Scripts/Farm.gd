extends Node

var initial_plot_amount = 1 # Initial amount of plots
var plots = [] # Array of plot instances

# Crop data, used to store and access the data on each crop
var crop_names = []
var crop_prices = []
var crop_harvests = []
var crop_grown_stages = []
var crop_stage_lengths = []

# Dictionary of resource names and amounts
var resources = {
	"Coins": 15,
	"Carrots": 0,
	"Potatoes": 0
}

# References for handling plot instances
onready var plot = load("res://Scenes/Plot.tscn") # Preloads plot instance
onready var plot_node = $PlotDisplay/Center/Plots # Plots parent node

# References for the resource display
onready var coin_amount = $ResourceDisplay/IconDisplay/CoinDisplay/CoinAmount
onready var carrot_amount = $ResourceDisplay/IconDisplay/CarrotDisplay/CarrotAmount
onready var potato_amount = $ResourceDisplay/IconDisplay/PotatoDisplay/PotatoAmount

# References for handling the shop functions
onready var shop = $ShopDisplay/Shop
onready var button_shop = $ShopButton

signal save(save_data)

# On ready, Creates initial plots
func _ready():
	get_crop_data()
	starter_plots(initial_plot_amount)
	update_resource_display()

# Instantiates the inital amount of plots into the plots array
func starter_plots(amount):
	for i in amount:
		plots.append(plot.instance())
		plot_node.add_child(plots[i])
		plots[i].connect("crop_harvested", self, "add_to_resources")
		plots[i].fill_plot(crop_names[0], 
						   crop_harvests[0], 
						   crop_grown_stages[0], 
						   crop_stage_lengths[0])
	update_columns()

# Adds plot instances to the plots array
func add_plot(crop_index):
	if (plots.size() > 0):
		plots.append(plot.instance())
		plot_node.add_child(plots[plots.size() - 1])
		plots[plots.size() - 1].connect("crop_harvested", self, "add_to_resources")
		plots[plots.size() - 1].fill_plot(crop_names[crop_index], 
										  crop_harvests[crop_index], 
										  crop_grown_stages[crop_index], 
										  crop_stage_lengths[crop_index])
	update_columns()

# Updates the amount of columns depending on the amount of crops
# Currently hardcoded, will fix soon
func update_columns():
	if (plots.size() == 4):
		plot_node.columns = 2
	if (plots.size() == 9):
		plot_node.columns = 3
	if (plots.size() == 16):
		plot_node.columns = 4
	if (plots.size() == 25):
		plot_node.columns = 5

# Add the specified amount of resources, and update the display
func add_to_resources(crop_name, amount):
	if (resources.has(crop_name)):
		resources[crop_name] = resources.get(crop_name) + amount
		resources["Coins"] += amount * 2
		update_resource_display()

# Remove the specified amount of resources, and update the display
func remove_from_resources(crop_name, amount):
	if (resources.has(crop_name)):
		resources[crop_name] = resources.get(crop_name) - amount
		update_resource_display()
	
# Updates the text of each resource display node
func update_resource_display():
	coin_amount.text = str(resources.get("Coins"))
	carrot_amount.text = str(resources.get("Carrots"))
	potato_amount.text = str(resources.get("Potatoes"))

# Toggles the shop display and shop button
func _on_ShopButton_pressed():
	if (shop.is_visible_in_tree()):
		button_shop.text = "SHOW SHOP"
	else:
		button_shop.text = "HIDE SHOP"
	shop.toggle_shop()

# On shop buy button, purchase the respective plot and crop
func _on_Shop_buy_crop(crop_index):
	if (resources.get("Coins") >= crop_prices[crop_index]):
		resources["Coins"] -= crop_prices[crop_index]
		add_plot(crop_index)
	update_resource_display()

# Parses the crop data from the crop data json file and stores the data
# in the crop arrays
func get_crop_data():
	var file = File.new()
	file.open("res://Data/crops.json", file.READ)
	var text = file.get_as_text()
	file.close()
	var crop_data = parse_json(text)
	for i in crop_data.crops.size():
		crop_names.append(crop_data.crops[i].crop_name)
		crop_prices.append(crop_data.crops[i].crop_price)
		crop_harvests.append(crop_data.crops[i].harvest_amount)
		crop_grown_stages.append(crop_data.crops[i].grown_stage)
		crop_stage_lengths.append(crop_data.crops[i].stage_length)
