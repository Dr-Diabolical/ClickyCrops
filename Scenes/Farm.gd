extends Node

export var plot_amount = 5
var plots = []
onready var plot = load("res://Scenes/Plot.tscn")

onready var plot_node = $Center/Plots

onready var crops = [
	"res://Scenes/Crops/Carrots.tscn"
]

func _ready():
	create_plots()

func create_plots():
	for n in plot_amount:
		plots.append(plot.instance())
		plot_node.add_child(plots[n])
	plots[2].fill_plot("Carrots", 5, 3, 1)
