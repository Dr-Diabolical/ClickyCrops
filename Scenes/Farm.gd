extends Node

var initial_plot_amount = 3 # Initial amount of plots
var plots = [] # Array of plot instances

onready var plot = load("res://Scenes/Plot.tscn") # Preloads plot instance
onready var plot_node = $PlotDisplay/Center/Plots # Plots parent node

# On ready, Creates initial plots
func _ready():
	create_plots()
	add_plots(1)

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
