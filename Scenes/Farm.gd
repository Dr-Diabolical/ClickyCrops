extends Node

var initial_plot_amount = 1 # Initial amount of plots
var plots = [] # Array of plot instances

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

# On ready, Creates initial plots
func _ready():
	starter_plots(initial_plot_amount)
	update_resource_display()

# Instantiates the inital amount of plots into the plots array
func starter_plots(amount):
	update_columns()
	for i in amount:
		plots.append(plot.instance())
		plot_node.add_child(plots[i])
		plots[i].connect("crop_harvested", self, "add_to_resources")
		plots[i].fill_plot("Carrots", 5, 3, 2)

# Adds plot instances to the plots array
func add_plots(amount, type):
	update_columns()
	for i in amount:
		plots.append(plot.instance())
		plot_node.add_child(plots[i + plots.size() - 1])
		plots[i + plots.size() - 1].connect("crop_harvested", self, "add_to_resources")
		if (type == "Carrots"):
			plots[i + plots.size() - 1].fill_plot("Carrots", 5, 3, 2)
		if (type == "Potatoes"):
			plots[i + plots.size() - 1].fill_plot("Potatoes", 8, 5, 4)

# For every 2 plots, add a column to the plot node grid
func update_columns():
	if (plots.size() % 2 == 0):
		plot_node.columns += 1

# Add the specified amount of resources, and update the display
func add_to_resources(crop_name, amount):
	if (resources.has(crop_name)):
		resources[crop_name] = resources.get(crop_name) + amount
		resources["Coins"] += 5
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

func _on_Shop_buy_crop(crop_name, cost):
	if (resources["Coins"] >= cost):
		resources["Coins"] -= cost
		if (crop_name == "Carrots"):
			add_plots(1, "Carrots")
		if (crop_name == "Potatoes"):
			add_plots(1, "Potatoes")
	update_resource_display()
