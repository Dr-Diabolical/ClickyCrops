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
	create_plots()
	plots[0].fill_plot("Carrots", 5, 3, 1)
	update_resource_display()

# Instantiates the inital amount of plots into the plots array
func create_plots():
	update_columns()
	for i in initial_plot_amount:
		plots.append(plot.instance())
		plots[i].connect("crop_harvested", self, "add_to_resources")
		plot_node.add_child(plots[i])

# Adds plot instances to the plots array
func add_plots(amount):
	update_columns()
	for i in amount:
		plots.append(plot.instance())
		plot_node.add_child(plots[i + initial_plot_amount])

# For every 2 plots, add a column to the plot node grid
func update_columns():
	if (plots.size() % 2 == 0):
		plot_node.columns += 1

# Add the specified amount of resources to the resource, and update the display
func add_to_resources(crop_name, crop_amount):
	if (resources.has(crop_name)):
		resources[crop_name] = resources.get(crop_name) + crop_amount
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
