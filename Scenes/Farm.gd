extends Node

var initial_plot_amount = 1 # Initial amount of plots
var plots = [] # Array of plot instances

onready var plot = load("res://Scenes/Plot.tscn") # Preloads plot instance
onready var plot_node = $PlotDisplay/Center/Plots # Plots parent node
onready var shop = $ShopDisplay/Shop
onready var button_shop = $ShopButton

# On ready, Creates initial plots
func _ready():
	create_plots()
	plots[0].fill_plot("Carrots", 5, 3, 1)

# Instantiates the inital amount of plots into the plots array
func create_plots():
	update_columns()
	for n in initial_plot_amount:
		plots.append(plot.instance())
		plot_node.add_child(plots[n])

# Adds plot instances to the plots array
func add_plots(amount):
	update_columns()
	for n in amount:
		plots.append(plot.instance())
		plot_node.add_child(plots[n + initial_plot_amount])

# For every 2 plots, add a column to the plot node grid
func update_columns():
	if (plots.size() % 2 == 0):
		plot_node.columns += 1

func _on_ShopButton_pressed():
	if (shop.is_visible_in_tree()):
		button_shop.text = "SHOW SHOP"
	else:
		button_shop.text = "HIDE SHOP"
	shop.toggle_shop()
