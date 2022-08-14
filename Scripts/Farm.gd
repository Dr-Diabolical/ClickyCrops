# Farm.gd
# Handles the player's farm, including the player's plots, resources, and save
# data
# Last modified: 10-12-2021

extends Node

# TODO: Allow for multiple save files by adding a variable in Game.gd that
# holds which file to use, then bring it here

# Crop data, used to store and access the data on each crop
var crop_names = []
var crop_prices = []
var crop_harvests = []
var crop_grown_stages = []
var crop_stage_lengths = []

# Dictionary of resource names and amounts
var resources = {
	"Coins": 0,
	"Carrots": 0,
	"Potatoes": 0
}

var plots = [] # Array of plot instances
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

# On ready, load plots and resources
func _ready():
	get_crop_data()
	load_plots()
	load_resources()
	update_resource_display()

# Loads the farm save data from the json file and instantiates each plot
func load_plots():
	var plot_data = get_save_data()
	for i in plot_data.plots.size():
		var index = crop_names.find(plot_data.plots[i].plot_crop_name, 0)
		plots.append(plot.instance())
		plot_node.add_child(plots[i])
		plots[i].connect("crop_harvested", self, "add_to_resources")
		plots[i].fill_plot(crop_names[index],
						   crop_harvests[index],
						   crop_grown_stages[index],
						   crop_stage_lengths[index])
		plots[i].set_stage(plot_data.plots[i].plot_crop_stage)
	update_columns()

# Loads the farm resource save data and applys the data for each crop resource
func load_resources():
	var resource_data = get_save_data()
	resources["Coins"] = resource_data.resources.Coins
	resources["Carrots"] = resource_data.resources.Carrots
	resources["Potatoes"] = resource_data.resources.Potatoes

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
# TODO: Make procedural and not hardcoded
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

# On shop buy button, add the correct plot and subtract resource
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

# Loads the farm save data from the save json file and returns the data
func get_save_data():
	var file = File.new()
	file.open("res://Data/save.json", file.READ)
	var text = file.get_as_text()
	file.close()
	return parse_json(text)

# Saves the farm data to the save json file
func save_data():
	var data = get_save_data()
	data.resources.Coins = resources.get("Coins")
	data.resources.Carrots = resources.get("Carrots")
	data.resources.Potatoes = resources.get("Potatoes")
	data.plots.clear()
	for i in plots.size():
		data.plots.append({"plot_crop_name": plots[i].crop_name,
						   "plot_crop_stage": plots[i].stage})
	
	var file = File.new()
	file.open("res://Data/save.json", file.WRITE)
	file.store_line(to_json(data))
	file.close()
