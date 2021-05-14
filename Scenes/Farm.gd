extends Node

var plot_amount = 3
var plots = []

onready var plot = load("res://Scenes/Plot.tscn")
onready var plot_node = $PlotDisplay/Center/Plots

func _ready():
	create_plots()
	add_plots(1)

func create_plots():
	update_columns()
	for n in plot_amount:
		plots.append(plot.instance())
		plot_node.add_child(plots[n])

func add_plots(amount):
	update_columns()
	for n in amount:
		plots.append(plot.instance())
		plot_node.add_child(plots[n + plot_amount])

func update_columns():
	if (plots.size() % 2 == 0):
		plot_node.columns += 1
